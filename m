Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03EB8C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 20:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB5D820720
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 20:17:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W4nuXczM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbgBCUR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 15:17:58 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26936 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726250AbgBCUR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 15:17:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580761075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RutAFnjTPWJQYvSXakp1wH+YCc3aiDR209+0rmd2tsA=;
        b=W4nuXczMPsnoUF6Vv4OG1sEtME2Zx7grV1D26CQVZ5svPgq08DCL4tOJxcPUned6IJmNTq
        a1CyuPTPXFo2Mj5eb0HQlQNec38PeOUkX9mGf5BUM+ebQkwyqfXktAqRXGJYct3cVOmDu3
        9jgY66difSio84NM6Sv+LdZSdyu+9jY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-K6SgvcyMNI-hwGVxcb2tDA-1; Mon, 03 Feb 2020 15:17:50 -0500
X-MC-Unique: K6SgvcyMNI-hwGVxcb2tDA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF651107ACCD;
        Mon,  3 Feb 2020 20:17:48 +0000 (UTC)
Received: from mail (ovpn-120-67.rdu2.redhat.com [10.10.120.67])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0F15819C58;
        Mon,  3 Feb 2020 20:17:46 +0000 (UTC)
From:   Andrea Arcangeli <aarcange@redhat.com>
To:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jon Masters <jcm@jonmasters.org>,
        Rafael Aquini <aquini@redhat.com>,
        Mark Salter <msalter@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org
Subject: [RFC] [PATCH 0/2] arm64: tlb: skip tlbi broadcast for single threaded TLB flushes
Date:   Mon,  3 Feb 2020 15:17:43 -0500
Message-Id: <20200203201745.29986-1-aarcange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

I've been testing the arm64 ARMv8 tlbi broadcast instruction and it
seems it doesn't scale in SMP, which opens the door for using similar
tricks to what alpha, ia64, mips, powerpc, sh, sparc are doing to
optimize TLB flushes for single threaded processes. This should be
even more beneficial in NUMA or multi socket systems where the "ASID"
and "vaddr" information has to cross a longer distance before the tlbi
broadcast instruction can be retired.

This mm_users logic seems non standard across different arches: every
arch does it in its own way. Not only the implementation is different,
but different arches are also trying to optimize different cases
through the mm_users checks in the arch code:

1) avoiding remote TLB flushes with mm_users <=3D 1

2) avoiding even local TLB flushes during exit_mmap->unmap_vmas when
   mm_users =3D=3D 0

For now I only tried to implement 1) on arm64, but I'm left wondering
which other arches can achieve 2) and in turn which kernel code could
write to the very userland virtual addresses being unmapped during
exit_mmap, that would strictly require their flushing using the tlb
gather mechanism.

This is just a RFC to know if this is would be a viable optimization.
A basic microbenchmark is included in the commit header of the patch.

Thanks,
Andrea

Andrea Arcangeli (2):
  mm: use_mm: fix for arches checking mm_users to optimize TLB flushes
  arm64: tlb: skip tlbi broadcast for single threaded TLB flushes

 arch/arm64/include/asm/efi.h         |  2 +-
 arch/arm64/include/asm/mmu.h         |  3 +-
 arch/arm64/include/asm/mmu_context.h | 10 +--
 arch/arm64/include/asm/tlbflush.h    | 91 +++++++++++++++++++++++++++-
 arch/arm64/mm/context.c              | 13 +++-
 mm/mmu_context.c                     |  2 +
 6 files changed, 111 insertions(+), 10 deletions(-)

Some examples of the scattered status of 2) follows:

ia64:

=3D=3D
flush_tlb_mm (struct mm_struct *mm)
{
	if (!mm)
		return;

	set_bit(mm->context, ia64_ctx.flushmap);
	mm->context =3D 0;

	if (atomic_read(&mm->mm_users) =3D=3D 0)
		return;		/* happens as a result of exit_mmap() */
[..]
=3D=3D

sparc:

=3D=3D
void flush_tlb_all(void)
{
	/*
	 * Don't bother flushing if this address space is about to be
	 * destroyed.
	 */
	if (atomic_read(&current->mm->mm_users) =3D=3D 0)
		return;
[..]
static void fix_range(struct mm_struct *mm, unsigned long start_addr,
		      unsigned long end_addr, int force)
{
	/*
	 * Don't bother flushing if this address space is about to be
	 * destroyed.
	 */
	if (atomic_read(&mm->mm_users) =3D=3D 0)
		return;
[..]
=3D=3D

arc:

=3D=3D
noinline void local_flush_tlb_mm(struct mm_struct *mm)
{
	/*
	 * Small optimisation courtesy IA64
	 * flush_mm called during fork,exit,munmap etc, multiple times as well.
	 * Only for fork( ) do we need to move parent to a new MMU ctxt,
	 * all other cases are NOPs, hence this check.
	 */
	if (atomic_read(&mm->mm_users) =3D=3D 0)
		return;
[..]
=3D=3D


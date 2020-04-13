Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A569C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA8212072D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:03:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=qubes-os.org header.i=frederic.pierret@qubes-os.org header.b="lQnrmEWv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730926AbgDMPDp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 11:03:45 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21398 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728578AbgDMPDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 11:03:44 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1586790203; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=NPb69smhNgO1P+KkviAiFToL+vKMqi7jVNTqvd+/2gnCbcv9y24R8zOws8A9OkHdGd4WmPuQPLlMakVNy1rUWrd0/p+jJmfMfV9zlWQA7pnRx2Py8/FadIUhgudpHY/NRqsSnTR/iFNS6Uf2vbnFW7intpBJv8O3naTSNT5Id3A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1586790203; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=9Pzk0cVzBCKcfGlQdKKLQ1SX00CFPc0gWvmG8POseOM=; 
        b=MFesFXbunyENNW1kui0k53JuRrrpwJH+11cLWpTcneejw5V5mk3Sw5hR0p5Eg6+C9ARxHNJ5lj9DAey+hIWjqUo3eSQm0EI6MEqg7BjJB+o7PGDkCDtBAyiJdi/MuEFXpW93FRg3ePdfgbavNAQq8lfMVjweEj2wCh7rHbZdBGs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=qubes-os.org;
        spf=pass  smtp.mailfrom=frederic.pierret@qubes-os.org;
        dmarc=pass header.from=<frederic.pierret@qubes-os.org> header.from=<frederic.pierret@qubes-os.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1586790203;
        s=s; d=qubes-os.org; i=frederic.pierret@qubes-os.org;
        h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding;
        bh=9Pzk0cVzBCKcfGlQdKKLQ1SX00CFPc0gWvmG8POseOM=;
        b=lQnrmEWviXsFurbfdGrSiWqbpl0fOrpU4MuSD2vtweWTqg8TBjCgvbLrOuC/dhRQ
        JqjaLXKKqWMIyNocT3CibI/HG3VPrcWN93/mREwU1NLSGgp5QQ29Dfr0z4RjPgdxNaG
        7BoCdkKZdl1RHX6/4wjqRYrnmtykfuv1SUDX10y4=
Received: from localhost.localdomain (92.188.110.153 [92.188.110.153]) by mx.zohomail.com
        with SMTPS id 1586790200760672.0712336468074; Mon, 13 Apr 2020 08:03:20 -0700 (PDT)
From:   =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Pierret=20=28fepitre=29?= 
        <frederic.pierret@qubes-os.org>
To:     boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Pierret=20=28fepitre=29?= 
        <frederic.pierret@qubes-os.org>
Message-ID: <20200413150314.13974-1-frederic.pierret@qubes-os.org>
Subject: [PATCH v2] xen x86: fix early boot crash with gcc-10
Date:   Mon, 13 Apr 2020 17:03:14 +0200
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200413142051.GC3772@zn.tnic>
References: <20200413142051.GC3772@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The change fixes boot failure on VM where kernel (at least v5.4 and v5.6)
is built with gcc-10 and STACKPROTECTOR_STRONG enabled:

```
Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: =
cpu_bringup_and_idle+0x93/0xa0
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.4.31-1.qubes.x86_64 #1
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.12.0-1 04/01/201=
4
Call Trace:
  dump_stack+0x64/0x88
   panic+0x10b/0x2ed
   ? cpu_bringup_and_idle+0x93/0xa0
   __stack_chk_fail+0x15/0x20
   cpu_bringup_and_idle+0x93/0xa
```
The change makes successfully booting the VM. The VM is hosted by
KVM hypervisor and is running Xen into.

Based on work done by Sergei Trofimovich: https://lkml.org/lkml/2020/3/26/1=
133

Signed-off-by: Fr=C3=A9d=C3=A9ric Pierret (fepitre) <frederic.pierret@qubes=
-os.org>
---
 arch/x86/xen/smp_pv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/xen/smp_pv.c b/arch/x86/xen/smp_pv.c
index 8fb8a50a28b4..5c8ee4a5bb0c 100644
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -88,7 +88,7 @@ static void cpu_bringup(void)
 =09local_irq_enable();
 }
=20
-asmlinkage __visible void cpu_bringup_and_idle(void)
+asmlinkage __visible void __no_stack_protector cpu_bringup_and_idle(void)
 {
 =09cpu_bringup();
 =09boot_init_stack_canary();
--=20
2.25.2



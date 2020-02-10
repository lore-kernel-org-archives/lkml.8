Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BB47C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E79B22173E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581338233;
	bh=mXZjmtU8ZBPx99jKMMldFF0RvJ/FI5u4/VQBKYH05oI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hticvwk09oP6K9x6eFg3m3ZOYwIeI6hfMBCXkYMdpzBTjL+3BjK7TTMTLFV1iB7bS
	 9Bxo8W/3xEw4Zu9KOPoy6k7SjQTrO/UW1r5NR9Dy1mbOaBgJKnJ/hNvfARnXUShLvp
	 +BJxS31gw10bsM216emR861NF7+yMyGBsa044VX8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgBJMhM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:37:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:54622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728251AbgBJMgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:36:07 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E5FE52168B;
        Mon, 10 Feb 2020 12:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338167;
        bh=mXZjmtU8ZBPx99jKMMldFF0RvJ/FI5u4/VQBKYH05oI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mIa5r4fj0CScb4ivUVH2DIIOX5lZSCANXI6SruEa2dwRllbYq79HkncucF2OrdYS0
         G3EPO0SBMWYX1R3XyH0dRUup8hGUZPhNHFpYaPGlUhYRAjIJAWZ3a912lIR0RqQnql
         rapX536P7crbt5YIQhV4NnucWEZK1qeX90rGsAs4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nick Finco <nifi@google.com>,
        Marios Pomonis <pomonis@google.com>,
        Andrew Honig <ahonig@google.com>,
        Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.19 129/195] KVM: x86: Protect ioapic_write_indirect() from Spectre-v1/L1TF attacks
Date:   Mon, 10 Feb 2020 04:33:07 -0800
Message-Id: <20200210122317.935673700@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122305.731206734@linuxfoundation.org>
References: <20200210122305.731206734@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marios Pomonis <pomonis@google.com>

commit 670564559ca35b439c8d8861fc399451ddf95137 upstream.

This fixes a Spectre-v1/L1TF vulnerability in ioapic_write_indirect().
This function contains index computations based on the
(attacker-controlled) IOREGSEL register.

This patch depends on patch
"KVM: x86: Protect ioapic_read_indirect() from Spectre-v1/L1TF attacks".

Fixes: 70f93dae32ac ("KVM: Use temporary variable to shorten lines.")

Signed-off-by: Nick Finco <nifi@google.com>
Signed-off-by: Marios Pomonis <pomonis@google.com>
Reviewed-by: Andrew Honig <ahonig@google.com>
Cc: stable@vger.kernel.org
Reviewed-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/ioapic.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/x86/kvm/ioapic.c
+++ b/arch/x86/kvm/ioapic.c
@@ -297,6 +297,7 @@ static void ioapic_write_indirect(struct
 		ioapic_debug("change redir index %x val %x\n", index, val);
 		if (index >= IOAPIC_NUM_PINS)
 			return;
+		index = array_index_nospec(index, IOAPIC_NUM_PINS);
 		e = &ioapic->redirtbl[index];
 		mask_before = e->fields.mask;
 		/* Preserve read-only fields */



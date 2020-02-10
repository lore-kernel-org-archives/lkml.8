Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FE5C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3B1820714
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 12:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581339566;
	bh=8os6H8DtanvHEZ70BPe9K7lodrlmiL+KbSO2NIDQA0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=urvQ1nXbmengSBiIXRHR/PrP8ilLwam9gYKw86jVsZnt7r5TyfspKruX9nVZGGAhF
	 q7N9lh+DvEh87dhEfU8D9NKiVkr/6h2pd1sWFydrAm8t4PAnqrM8mooJGdejJyboHi
	 TfTgzHRa3WPprT7rl3/3pkrZtA3RTCes0+kvpDe4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgBJM7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:59:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:42770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729911AbgBJMlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:41:10 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA3682080C;
        Mon, 10 Feb 2020 12:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338469;
        bh=8os6H8DtanvHEZ70BPe9K7lodrlmiL+KbSO2NIDQA0Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DG/Zq7fmZnpQYBCmeBALwAXvRbqsysKOZH5IPc0wMin6eErY4gP9/hikpZk2gglIW
         K6pYR41OzyfqQP42gFaT/MU6uRP9qx+0woHfql8lkKRK+RHM+wk+yG0KvIvJGD4mHJ
         Jd4sakxDrQ9v0bmgXiZoCiQz9+XPTsDOy/7qgvFM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nick Finco <nifi@google.com>,
        Marios Pomonis <pomonis@google.com>,
        Andrew Honig <ahonig@google.com>,
        Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.5 233/367] KVM: x86: Protect ioapic_write_indirect() from Spectre-v1/L1TF attacks
Date:   Mon, 10 Feb 2020 04:32:26 -0800
Message-Id: <20200210122445.722731428@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200210122423.695146547@linuxfoundation.org>
References: <20200210122423.695146547@linuxfoundation.org>
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
@@ -292,6 +292,7 @@ static void ioapic_write_indirect(struct
 
 		if (index >= IOAPIC_NUM_PINS)
 			return;
+		index = array_index_nospec(index, IOAPIC_NUM_PINS);
 		e = &ioapic->redirtbl[index];
 		mask_before = e->fields.mask;
 		/* Preserve read-only fields */



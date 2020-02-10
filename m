Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68757C352A3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E972082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 13:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581341160;
	bh=CSrHh6ckbplG7cDGcTH5GkDJu+ynBZmL5i67RFtgq/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SHRKVx/EDfYNFbJyZLg/8dNcXKK+2gJJ5U4wKttoDZ8KP/WvmyttsJkVJdzgUgdsr
	 GaafTR8YFPRhX6jv7aqy2NXP4qWjzJda2eGltApOytyURSdTUdOmRouxVYNDIRRjgD
	 Fia/ziu6cUyQnE9z049cnjERS5oMS+aSXcICJ2t0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbgBJMgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 07:36:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:53642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728182AbgBJMf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 07:35:56 -0500
Received: from localhost (unknown [209.37.97.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A6CE20838;
        Mon, 10 Feb 2020 12:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581338156;
        bh=CSrHh6ckbplG7cDGcTH5GkDJu+ynBZmL5i67RFtgq/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Be1TNtZvjuasYFGFB9RKjzITsKB/LhvB8uhYX8NqxCTA82CkSMqWWy5ORYkepnxNC
         ByRZXrrKD/do6uHc1sEjc9b3VGZ4tiusy+PHp5r/O7RfW8TESb56nRtxeiPS7zJcKN
         ZgU0C1JvfDZYnUtI+MfN+GTobeHWJrV1Krczhbyg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nick Finco <nifi@google.com>,
        Marios Pomonis <pomonis@google.com>,
        Andrew Honig <ahonig@google.com>,
        Jim Mattson <jmattson@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.19 123/195] KVM: x86: Refactor picdev_write() to prevent Spectre-v1/L1TF attacks
Date:   Mon, 10 Feb 2020 04:33:01 -0800
Message-Id: <20200210122317.434626582@linuxfoundation.org>
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

commit 14e32321f3606e4b0970200b6e5e47ee6f1e6410 upstream.

This fixes a Spectre-v1/L1TF vulnerability in picdev_write().
It replaces index computations based on the (attacked-controlled) port
number with constants through a minor refactoring.

Fixes: 85f455f7ddbe ("KVM: Add support for in-kernel PIC emulation")

Signed-off-by: Nick Finco <nifi@google.com>
Signed-off-by: Marios Pomonis <pomonis@google.com>
Reviewed-by: Andrew Honig <ahonig@google.com>
Cc: stable@vger.kernel.org
Reviewed-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/i8259.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/arch/x86/kvm/i8259.c
+++ b/arch/x86/kvm/i8259.c
@@ -460,10 +460,14 @@ static int picdev_write(struct kvm_pic *
 	switch (addr) {
 	case 0x20:
 	case 0x21:
+		pic_lock(s);
+		pic_ioport_write(&s->pics[0], addr, data);
+		pic_unlock(s);
+		break;
 	case 0xa0:
 	case 0xa1:
 		pic_lock(s);
-		pic_ioport_write(&s->pics[addr >> 7], addr, data);
+		pic_ioport_write(&s->pics[1], addr, data);
 		pic_unlock(s);
 		break;
 	case 0x4d0:



Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6EEC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30C6520873
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 17:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589823702;
	bh=+jvSoIIa24wM8YY3J5dMy5VGin8vj9b9xKcxlTcyGoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JwrBdnsRkGkW1b4036vReQFUK/mIknITwDeOjTuDQPCVEXM0nRXD2IYOa3y2cHGDr
	 KfTqjpCbMShbvZljTyrsSqQ72JHCqUFYyhw9zAxgNESXoPfQsGTNWK66JCI2yAsefY
	 6gTW7sQUdrg+DIIiVRwaFF1vTwZn/keeTGcHM+d4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729309AbgERRll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 13:41:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:38096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729297AbgERRlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 13:41:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0557C20715;
        Mon, 18 May 2020 17:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589823697;
        bh=+jvSoIIa24wM8YY3J5dMy5VGin8vj9b9xKcxlTcyGoo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HX8Z9SCcbS9Nc9iBq3SEdtsVGBuH9LzytOXrjlg3ya5YVK9EVCC0+2IR+664iY2Fb
         5rpxBsFQ/OoBlqR32hpWoXKw25xcZFPJe3vUyVACigoKIAuaUMaVPBDd7KD0K4NJwS
         H8jpVOgfSsbEA2mcum2PhoiCufDb6iRt1Qo1TYXo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jue Wang <juew@google.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Shier <pshier@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.4 85/86] KVM: x86: Fix off-by-one error in kvm_vcpu_ioctl_x86_setup_mce
Date:   Mon, 18 May 2020 19:36:56 +0200
Message-Id: <20200518173507.791136986@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200518173450.254571947@linuxfoundation.org>
References: <20200518173450.254571947@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jim Mattson <jmattson@google.com>

commit c4e0e4ab4cf3ec2b3f0b628ead108d677644ebd9 upstream.

Bank_num is a one-based count of banks, not a zero-based index. It
overflows the allocated space only when strictly greater than
KVM_MAX_MCE_BANKS.

Fixes: a9e38c3e01ad ("KVM: x86: Catch potential overrun in MCE setup")
Signed-off-by: Jue Wang <juew@google.com>
Signed-off-by: Jim Mattson <jmattson@google.com>
Reviewed-by: Peter Shier <pshier@google.com>
Message-Id: <20200511225616.19557-1-jmattson@google.com>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/x86.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2941,7 +2941,7 @@ static int kvm_vcpu_ioctl_x86_setup_mce(
 	unsigned bank_num = mcg_cap & 0xff, bank;
 
 	r = -EINVAL;
-	if (!bank_num || bank_num >= KVM_MAX_MCE_BANKS)
+	if (!bank_num || bank_num > KVM_MAX_MCE_BANKS)
 		goto out;
 	if (mcg_cap & ~(KVM_MCE_CAP_SUPPORTED | 0xff | 0xff0000))
 		goto out;



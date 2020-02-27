Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A716BC54FDC
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74CFA20801
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582813846;
	bh=B0g55lzRnHh7dRAuqmvIiO2W1H2pOCKPIirhLswgmKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PnWGvP7+HyNBzTUB6lWzBLE6Wk/mN0QaiLvoVWrtiu32dGiTpPrTjS4o/Yz29hFEU
	 9iRORwdDmv0spkOiMni+CpytIFPJ4HFfkDxOfbx1y+m5Ej2NVo+s7E9JjxiKoAEOsM
	 xFhjVUAT1vUjmg17WtDm6byi2sS6RznzfzDRH6WA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733225AbgB0OEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:04:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:41054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387618AbgB0OEi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:04:38 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAEE420578;
        Thu, 27 Feb 2020 14:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582812278;
        bh=B0g55lzRnHh7dRAuqmvIiO2W1H2pOCKPIirhLswgmKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kPQf5TcVwIat892TDg8ANMYSz1q79QDFP6XNZI4ClAEO6rDQJa/G7d9Ub2aAjwFWu
         rSQiIUXmEcjCx/QjUoemjMJt4p01iN+rWAxi4dKuu8luaxQPWLIJnnfdkJsqrLqcmV
         qyAKU0fB8I3A/I5sr97od1wvdUivBH1avzlynpzw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Oliver Upton <oupton@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.19 52/97] KVM: nVMX: Dont emulate instructions in guest mode
Date:   Thu, 27 Feb 2020 14:37:00 +0100
Message-Id: <20200227132223.073941417@linuxfoundation.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200227132214.553656188@linuxfoundation.org>
References: <20200227132214.553656188@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

commit 07721feee46b4b248402133228235318199b05ec upstream.

vmx_check_intercept is not yet fully implemented. To avoid emulating
instructions disallowed by the L1 hypervisor, refuse to emulate
instructions by default.

Cc: stable@vger.kernel.org
[Made commit, added commit msg - Oliver]
Signed-off-by: Oliver Upton <oupton@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/vmx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/kvm/vmx.c
+++ b/arch/x86/kvm/vmx.c
@@ -13694,7 +13694,7 @@ static int vmx_check_intercept(struct kv
 	}
 
 	/* TODO: check more intercepts... */
-	return X86EMUL_CONTINUE;
+	return X86EMUL_UNHANDLEABLE;
 }
 
 #ifdef CONFIG_X86_64



Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01681CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCB9B20753
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589363385;
	bh=OBjA4hsPp4PLfpQ8jjfg+PmSNwEel0QxiScbjp+evq0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cZ803IVoS3l9ai5SkR4pONVOa5KkFkRBJHd/KD//RibrvIzlO6N9d7MIHgEad77k4
	 +DTDGQLnrMlSuKDYXTxqir9PLaBkJMVZiCHewgH45m++iDrAHORTfwb9CNri1ZZ+TV
	 /tz8x//PKYVXDxOrUSE4OEIP2LQ4Ofoha4J7eOc0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733289AbgEMJtp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 05:49:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:48902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733282AbgEMJtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:49:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9BFA23126;
        Wed, 13 May 2020 09:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589363380;
        bh=OBjA4hsPp4PLfpQ8jjfg+PmSNwEel0QxiScbjp+evq0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gmfp9PtJC5UZ768ssv3TMiKhWX8wSaoJvczeait7mwcCyme7duqav+xp4xH0ANGTV
         IeB8C/rFECm1vIzYMdUJq8L0iKDoc//YTebQagR3W8RyNRg2zQJQy4cgINYLPcz3r0
         iMCoOTawUrSGF3Yj8v3Dzw7Bc+s+XeCPFcV6BRho=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pierre Morel <pmorel@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Qian Cai <cailca@icloud.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: [PATCH 5.4 51/90] KVM: s390: Remove false WARN_ON_ONCE for the PQAP instruction
Date:   Wed, 13 May 2020 11:44:47 +0200
Message-Id: <20200513094414.195096237@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513094408.810028856@linuxfoundation.org>
References: <20200513094408.810028856@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Borntraeger <borntraeger@de.ibm.com>

commit 5615e74f48dcc982655543e979b6c3f3f877e6f6 upstream.

In LPAR we will only get an intercept for FC==3 for the PQAP
instruction. Running nested under z/VM can result in other intercepts as
well as ECA_APIE is an effective bit: If one hypervisor layer has
turned this bit off, the end result will be that we will get intercepts for
all function codes. Usually the first one will be a query like PQAP(QCI).
So the WARN_ON_ONCE is not right. Let us simply remove it.

Cc: Pierre Morel <pmorel@linux.ibm.com>
Cc: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: stable@vger.kernel.org # v5.3+
Fixes: e5282de93105 ("s390: ap: kvm: add PQAP interception for AQIC")
Link: https://lore.kernel.org/kvm/20200505083515.2720-1-borntraeger@de.ibm.com
Reported-by: Qian Cai <cailca@icloud.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/s390/kvm/priv.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -626,10 +626,12 @@ static int handle_pqap(struct kvm_vcpu *
 	 * available for the guest are AQIC and TAPQ with the t bit set
 	 * since we do not set IC.3 (FIII) we currently will only intercept
 	 * the AQIC function code.
+	 * Note: running nested under z/VM can result in intercepts for other
+	 * function codes, e.g. PQAP(QCI). We do not support this and bail out.
 	 */
 	reg0 = vcpu->run->s.regs.gprs[0];
 	fc = (reg0 >> 24) & 0xff;
-	if (WARN_ON_ONCE(fc != 0x03))
+	if (fc != 0x03)
 		return -EOPNOTSUPP;
 
 	/* PQAP instruction is allowed for guest kernel only */



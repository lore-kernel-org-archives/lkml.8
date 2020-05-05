Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4165EC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 10:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BBE520735
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 10:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588675378;
	bh=NLCbmdO5jXwPTRJmev5nd5sqfYdfydo3KQgdzeupCVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NfjSd6jd7Jby0c15HqNFz6CoH+TfZWRirT8bSTHKdkLwaF9yenG7jw6sqPyHoDKRt
	 MUkNgPrMMmAHatmv5Xo7Gb33lVKYFr7XY7z4w0ehv3mPQfV/d4sUzxLOdDiJZfqibG
	 r3JWmrq4R5qmZ4F2I/vP0v43lmBoRJnOtO2VaaYs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbgEEKm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 06:42:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:54904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728660AbgEEKm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 06:42:57 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1FFD206A5;
        Tue,  5 May 2020 10:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588675376;
        bh=NLCbmdO5jXwPTRJmev5nd5sqfYdfydo3KQgdzeupCVw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2Jo+b3eyoAVOg/5340CGqyTb2jUUFWj37ojZOsHWNQHkvvtQZjiUq62H2OVcZpHI8
         LNS3z8WXpoQpIIY5GRyImbq8O3W8Ogr1KK3IQrKm19FzqGdfXNkkrLP5pfBeMviVoF
         Fud8qYMJPVqmMU28sgyb2quRfLYtIq3//48fkSKA=
Date:   Tue, 5 May 2020 11:42:51 +0100
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 02/16] arm64/cpufeature: Drop TraceFilt feature
 exposure from ID_DFR0 register
Message-ID: <20200505104250.GA19710@willie-the-truck>
References: <1588426445-24344-1-git-send-email-anshuman.khandual@arm.com>
 <1588426445-24344-3-git-send-email-anshuman.khandual@arm.com>
 <20200504202453.GA5012@willie-the-truck>
 <56cd3062-a0c2-6cdf-b7c6-c2b7bf56d23b@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56cd3062-a0c2-6cdf-b7c6-c2b7bf56d23b@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 12:20:41PM +0530, Anshuman Khandual wrote:
> On 05/05/2020 01:54 AM, Will Deacon wrote:
> > On Sat, May 02, 2020 at 07:03:51PM +0530, Anshuman Khandual wrote:
> >> ID_DFR0 based TraceFilt feature should not be exposed to guests. Hence lets
> >> drop it.
> >>
> >> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >> Cc: Will Deacon <will@kernel.org>
> >> Cc: Marc Zyngier <maz@kernel.org>
> >> Cc: Mark Rutland <mark.rutland@arm.com>
> >> Cc: James Morse <james.morse@arm.com>
> >> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> >> Cc: linux-arm-kernel@lists.infradead.org
> >> Cc: linux-kernel@vger.kernel.org
> >>
> >> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> >> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> >> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> >> ---
> >>  arch/arm64/kernel/cpufeature.c | 1 -
> >>  1 file changed, 1 deletion(-)
> >>
> >> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> >> index 6d032fbe416f..51386dade423 100644
> >> --- a/arch/arm64/kernel/cpufeature.c
> >> +++ b/arch/arm64/kernel/cpufeature.c
> >> @@ -435,7 +435,6 @@ static const struct arm64_ftr_bits ftr_id_pfr1[] = {
> >>  };
> >>  
> >>  static const struct arm64_ftr_bits ftr_id_dfr0[] = {
> >> -	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 28, 4, 0),
> > 
> > Hmm, this still confuses me. Is this not now FTR_NONSTRICT? Why is that ok?
> 
> Mark had mentioned about it earlier (https://patchwork.kernel.org/patch/11287805/)
> Did I misinterpret the first part ? Could not figure "capping the emulated debug
> features" part. Probably, Mark could give some more details.
> 
> From the earlier discussion:
> 
> * ID_DFR0 fields need more thought; we should limit what we expose here.
>   I don't think it's valid for us to expose TraceFilt, and I suspect we
>   need to add capping for debug features we currently emulate.

Sorry, I for confused (again) by the cpufeature code :) I'm going to add
the following to my comment:


diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index c1d44d127baa..9b05843d67af 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -53,6 +53,11 @@
  *   arbitrary physical CPUs, but some features not present on the host are
  *   also advertised and emulated. Look at sys_reg_descs[] for the gory
  *   details.
+ *
+ * - If the arm64_ftr_bits[] for a register has a missing field, then this
+ *   field is treated as STRICT RES0, including for read_sanitised_ftr_reg().
+ *   This is stronger than FTR_HIDDEN and can be used to hide features from
+ *   KVM guests.
  */
 
 #define pr_fmt(fmt) "CPU features: " fmt


However, I think we really want to get rid of ftr_generic_32bits[] entirely
and spell out all of the register fields, even just using comments for the
fields we're omitting:


@@ -425,7 +430,7 @@ static const struct arm64_ftr_bits ftr_id_pfr1[] = {
 };
 
 static const struct arm64_ftr_bits ftr_id_dfr0[] = {
-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 28, 4, 0),
+	/* 31:28	TraceFilt */
 	S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 24, 4, 0xf),	/* PerfMon */
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 20, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 16, 4, 0),


Longer term, I think we'll probably want to handle these within
ARM64_FTR_BITS, as we may end up with features that we want to hide from
KVM guests but not from the host kernel.

Will

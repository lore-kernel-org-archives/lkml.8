Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AE1C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 01:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C313C20675
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 01:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597281952;
	bh=qIzZXfltMZ2c8wweV3aCSivjOgKWA6wcnMyMvK5rvOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BLyvgfZYf9iGKKF9Cueq2okD+Zkgca0KOgSWMAUZE7UebzsSC2aQ+gp3szPG102qz
	 oFpzFk0YTXDCIIaE68zJgF0PV6d2bDv1/Z0ceBAnXtKQOFq0JIyww8AC/D9SwAoPAM
	 QMCstUX/U9BezXl1u4D0Bk2rUyv0Tj4AmpcUlAHQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgHMBZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 21:25:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:35186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725869AbgHMBZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 21:25:51 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6056A205CB;
        Thu, 13 Aug 2020 01:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597281950;
        bh=qIzZXfltMZ2c8wweV3aCSivjOgKWA6wcnMyMvK5rvOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xzxPv8NhPd3bdEBw0WOvPDRCmOSCtSWI/RjMbtBdB9WqYX1VHf7qKA+3I7/8/HKp/
         E/Hfu5DlQH6KVIGGgAyIu5w6dq8GfBfYYh9dcLMoxRSZ5e/p0776Ji/dZ0foJKbhfg
         R0nX1GNIG3+sILDhplnkvtvcE1+Ox6ynJPuJZEWM=
Date:   Wed, 12 Aug 2020 18:25:48 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Alim Akhtar <alim.akhtar@samsung.com>
Cc:     robh@kernel.org, devicetree@vger.kernel.org,
        linux-scsi@vger.kernel.org, krzk@kernel.org, avri.altman@wdc.com,
        martin.petersen@oracle.com, kwmad.kim@samsung.com,
        stanley.chu@mediatek.com, cang@codeaurora.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kishon@ti.com
Subject: Re: [RESEND PATCH v10 04/10] scsi: ufs: introduce
 UFSHCD_QUIRK_PRDT_BYTE_GRAN quirk
Message-ID: <20200813012548.GA1782889@gmail.com>
References: <20200613024706.27975-1-alim.akhtar@samsung.com>
 <CGME20200613030445epcas5p4428da322cd9527d1075ff0f1ccc75d23@epcas5p4.samsung.com>
 <20200613024706.27975-5-alim.akhtar@samsung.com>
 <20200812002920.GA1352011@gmail.com>
 <000401d67110$0be2d9c0$23a88d40$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000401d67110$0be2d9c0$23a88d40$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 06:51:13AM +0530, Alim Akhtar wrote:
> Hi Eric,
> 
> > -----Original Message-----
> > From: Eric Biggers <ebiggers@kernel.org>
> > Sent: 12 August 2020 05:59
> > To: Alim Akhtar <alim.akhtar@samsung.com>
> > Cc: robh@kernel.org; devicetree@vger.kernel.org;
> linux-scsi@vger.kernel.org;
> > krzk@kernel.org; avri.altman@wdc.com; martin.petersen@oracle.com;
> > kwmad.kim@samsung.com; stanley.chu@mediatek.com;
> > cang@codeaurora.org; linux-samsung-soc@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; linux-kernel@vger.kernel.org; kishon@ti.com
> > Subject: Re: [RESEND PATCH v10 04/10] scsi: ufs: introduce
> > UFSHCD_QUIRK_PRDT_BYTE_GRAN quirk
> > 
> > Hi Alim,
> > 
> > On Sat, Jun 13, 2020 at 08:17:00AM +0530, Alim Akhtar wrote:
> > > Some UFS host controllers like Exynos uses granularities of PRDT
> > > length and offset as bytes, whereas others uses actual segment count.
> > >
> > > Reviewed-by: Avri Altman <avri.altman@wdc.com>
> > > Signed-off-by: Kiwoong Kim <kwmad.kim@samsung.com>
> > > Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> > > ---
> > >  drivers/scsi/ufs/ufshcd.c | 30 +++++++++++++++++++++++-------
> > > drivers/scsi/ufs/ufshcd.h |  6 ++++++
> > >  2 files changed, 29 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
> > > index ee30ed6cc805..ba093d0d0942 100644
> > > --- a/drivers/scsi/ufs/ufshcd.c
> > > +++ b/drivers/scsi/ufs/ufshcd.c
> > > @@ -2151,8 +2151,14 @@ static int ufshcd_map_sg(struct ufs_hba *hba,
> > struct ufshcd_lrb *lrbp)
> > >  		return sg_segments;
> > >
> > >  	if (sg_segments) {
> > > -		lrbp->utr_descriptor_ptr->prd_table_length =
> > > -			cpu_to_le16((u16)sg_segments);
> > > +
> > > +		if (hba->quirks & UFSHCD_QUIRK_PRDT_BYTE_GRAN)
> > > +			lrbp->utr_descriptor_ptr->prd_table_length =
> > > +				cpu_to_le16((sg_segments *
> > > +					sizeof(struct ufshcd_sg_entry)));
> > > +		else
> > > +			lrbp->utr_descriptor_ptr->prd_table_length =
> > > +				cpu_to_le16((u16) (sg_segments));
> > >
> > >  		prd_table = (struct ufshcd_sg_entry *)lrbp->ucd_prdt_ptr;
> > >
> > > @@ -3500,11 +3506,21 @@ static void
> > ufshcd_host_memory_configure(struct ufs_hba *hba)
> > >
> > 	cpu_to_le32(upper_32_bits(cmd_desc_element_addr));
> > >
> > >  		/* Response upiu and prdt offset should be in double words
> */
> > > -		utrdlp[i].response_upiu_offset =
> > > -			cpu_to_le16(response_offset >> 2);
> > > -		utrdlp[i].prd_table_offset = cpu_to_le16(prdt_offset >> 2);
> > > -		utrdlp[i].response_upiu_length =
> > > -			cpu_to_le16(ALIGNED_UPIU_SIZE >> 2);
> > > +		if (hba->quirks & UFSHCD_QUIRK_PRDT_BYTE_GRAN) {
> > > +			utrdlp[i].response_upiu_offset =
> > > +				cpu_to_le16(response_offset);
> > > +			utrdlp[i].prd_table_offset =
> > > +				cpu_to_le16(prdt_offset);
> > > +			utrdlp[i].response_upiu_length =
> > > +				cpu_to_le16(ALIGNED_UPIU_SIZE);
> > > +		} else {
> > > +			utrdlp[i].response_upiu_offset =
> > > +				cpu_to_le16(response_offset >> 2);
> > > +			utrdlp[i].prd_table_offset =
> > > +				cpu_to_le16(prdt_offset >> 2);
> > > +			utrdlp[i].response_upiu_length =
> > > +				cpu_to_le16(ALIGNED_UPIU_SIZE >> 2);
> > > +		}
> > >
> > >  		ufshcd_init_lrb(hba, &hba->lrb[i], i);
> > >  	}
> > 
> > Isn't this patch missing an update to ufshcd_print_trs()?  It uses
> > ->prd_table_length as the number of segments, not the number of bytes.
> > 
> prd_table_length will be populated before it reaches ufshcd_print_trs()
> based on UFSHCD_QUIRK_PRDT_BYTE_GRAN.
> 

Yes, which is why it seems ufshcd_print_trs() needs to be updated to take
UFSHCD_QUIRK_PRDT_BYTE_GRAN into account.

- Eric

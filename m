Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8621FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 12:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B3B6207FC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 12:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595248921;
	bh=4yz1mHQSyMFEDoN52XWPGE0sCqO1YBjUJNDznb4FZdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GhWt/XiEpruNLS9kUBtN07pqxu3APMIQH5q5tVOUNeGZHPmgF7SRWSLM6YnafroJ0
	 marcGl60z2bQADa8zylFTzT0O7ugu7CUkCOwcBWDD5jwpXe8WmstBvuW74zGL2gTRf
	 vMTwshkGs+mAkL3IjZcsQLCKmf0rBArkCZ94n+Q0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728532AbgGTMmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 08:42:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:37870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728074AbgGTMmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 08:42:00 -0400
Received: from localhost (unknown [122.171.202.192])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB9862070A;
        Mon, 20 Jul 2020 12:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595248919;
        bh=4yz1mHQSyMFEDoN52XWPGE0sCqO1YBjUJNDznb4FZdg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VseEDFQ8rEDcT17+j/uOZo8OcutPYZrPvWjr5SdDIH2nX6u4LzPK7X/C/vmuWYXwn
         QCeqnuoKgaRJBP0dWQ/+sOo4/35uuKv405eVGypPmL0vX+sZrobHQFSC5XLeGrFgna
         C3snPJxPTvDNZnq4zBER1Vmny7BF0Q5/o3loy6Rw=
Date:   Mon, 20 Jul 2020 18:11:55 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     ansuelsmth@gmail.com
Cc:     'Andy Gross' <agross@codeaurora.org>,
        'Jonathan McDowell' <noodles@earth.li>,
        'Andy Gross' <agross@kernel.org>,
        'Bjorn Andersson' <bjorn.andersson@linaro.org>,
        'Kishon Vijay Abraham I' <kishon@ti.com>,
        'Rob Herring' <robh+dt@kernel.org>,
        'Mark Rutland' <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: R: [PATCH v10 1/2] phy: qualcomm: add qcom ipq806x dwc usb phy
 driver
Message-ID: <20200720124155.GI12965@vkoul-mobl>
References: <20200717131635.11076-1-ansuelsmth@gmail.com>
 <20200720062545.GC12965@vkoul-mobl>
 <010801d65e90$d57d2b60$80778220$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <010801d65e90$d57d2b60$80778220$@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-07-20, 14:25, ansuelsmth@gmail.com wrote:
> 
> 
> > -----Messaggio originale-----
> > Da: Vinod Koul <vkoul@kernel.org>
> > Inviato: lunedì 20 luglio 2020 08:26
> > A: Ansuel Smith <ansuelsmth@gmail.com>
> > Cc: Andy Gross <agross@codeaurora.org>; Jonathan McDowell
> > <noodles@earth.li>; Andy Gross <agross@kernel.org>; Bjorn Andersson
> > <bjorn.andersson@linaro.org>; Kishon Vijay Abraham I <kishon@ti.com>;
> > Rob Herring <robh+dt@kernel.org>; Mark Rutland
> > <mark.rutland@arm.com>; linux-arm-msm@vger.kernel.org; linux-
> > kernel@vger.kernel.org; devicetree@vger.kernel.org
> > Oggetto: Re: [PATCH v10 1/2] phy: qualcomm: add qcom ipq806x dwc usb
> > phy driver
> > 
> > On 17-07-20, 15:16, Ansuel Smith wrote:
> > > This has lost in the original push for the dwc3 qcom driver.
> > > This is needed for ipq806x SoC as without this the usb ports
> > > doesn't work at all.
> > 
> > Applied both, thanks
> > 
> > My script found below errors with W=1, can you please send fixes for
> > these
> > 
> 
> Since you applied them should I send a new patch or a v11 of 
> this patchset?

new patches... Updates on top of phy-next please

-- 
~Vinod

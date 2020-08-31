Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0BB1C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 860162073A
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 09:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598865583;
	bh=VbOMNr9+mlKhviNnhhuAnntR0pqtI1g4GOH3sYhR2rk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=M7UYnYEpjXJ+YyekbtQDKnCMoFPlqawTKaSDX2pWcxZec7YVTEjX0UXAA3v2h3ySB
	 YUqYyypxrNQ6DMPmRHCtVTwAVXoLQNFk5o07/I52uwkeDzSbSd9z5TjwKEJe5sBfL0
	 ZPs6QZkh0wdWsOWPOb01hn3LnIIWwhEEs97BjGTE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbgHaJTm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 05:19:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:55198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728103AbgHaJTl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 05:19:41 -0400
Received: from localhost (unknown [122.171.38.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC4DF2073A;
        Mon, 31 Aug 2020 09:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598865580;
        bh=VbOMNr9+mlKhviNnhhuAnntR0pqtI1g4GOH3sYhR2rk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pYmVfXeYXprV+l9Ii2m95YRdQE1u0CZ2sGQXb89oayh7pHNcWGejr4Z+IsUA9+9o8
         DJ+rSfKQV0Zk2gL8HEQWveffbA6/CRSnIme71+fXGJLN9FxTehkzrb5iq6Dns5vWI+
         Xj6gWxTR94UlPEHvT+JFXM+Dff1NwyZZbSGRC6ik=
Date:   Mon, 31 Aug 2020 14:49:36 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Cc:     kishon@ti.com, robh+dt@kernel.org, andriy.shevchenko@intel.com,
        eswara.kota@linux.intel.com,
        vadivel.muruganx.ramuthevar@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v7 3/3] phy: intel: Add Keem Bay eMMC PHY support
Message-ID: <20200831091936.GM2639@vkoul-mobl>
References: <20200821113747.2912-1-wan.ahmad.zainie.wan.mohamad@intel.com>
 <20200821113747.2912-4-wan.ahmad.zainie.wan.mohamad@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821113747.2912-4-wan.ahmad.zainie.wan.mohamad@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-08-20, 19:37, Wan Ahmad Zainie wrote:

> +/* From ACS_eMMC51_16nFFC_RO1100_Userguide_v1p0.pdf p17 */
> +#define FREQSEL_200M_170M	0x0
> +#define FREQSEL_170M_140M	0x1
> +#define FREQSEL_140M_110M	0x2
> +#define FREQSEL_110M_80M	0x3
> +#define FREQSEL_80M_50M		0x4
> +
> +#define maskval(mask, val)	(((val) << (ffs(mask) - 1)) & mask)

Kernel has a macro do this for you, please use FIELD_PREP instead of

your own macro
-- 
~Vinod

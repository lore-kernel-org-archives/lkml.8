Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D10C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 07:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B90E2080C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 07:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593157018;
	bh=mBPI0lc0dNZZ+FByCzyLe+VxON0R9+24IuiJZtxjOXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HRrIW9qTcOjHg1aioPC30qcazgbLZ1YKm8eEm17weq7hy4/PP9jB6d1/apVHioRod
	 PBl+3OVvXArBiWuMY4sDUyd4EZwn845kle8zkGK/3n4dGKSA42QraMQ+Hq8ukDwkx7
	 DCbuHrfwQIRsFL/tDNaSOm42Om1hSk0rdzkPSf90=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbgFZHg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 03:36:57 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43436 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728082AbgFZHg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 03:36:56 -0400
Received: by mail-lf1-f65.google.com with SMTP id g139so4598516lfd.10;
        Fri, 26 Jun 2020 00:36:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Z1GuqjxXj0a5brCAz0bg4jdrPWPLFBvV4Bc0SO/JPkQ=;
        b=bC3K5LpV/spVJirEnCKlrOHAZvz63iF8bPk/L24EmjDdYCDMF4SKd6M41VEs8kX67g
         iV5eNjY8rCoJHCwTG0RfFiB+HUVMDD4biyjVQXYTZBaipjQ8FcNNZAf57PW82Scok0vK
         T1gOF1qIr70ZO3UbQ57j1h1MFsrhskzIjKdByVJOCab2RMHgRNn3FzVT6eH0RJRy85ws
         6JAMCYfDinB5p4n57EvVNNM7qx3zNPL/v5b1Qa/PZnM9xVMEvSDAvpz1X88qZnV1UGpw
         6yl5DIr0ktmkFUtNtotMyq1j29kZM5iwfTS3fAooQh1hk+jiDTpsYEDO0E2j0fbM5/VM
         krtA==
X-Gm-Message-State: AOAM533fVOjZcT2elW3w21/I+QHOtpizLo95NKszpYdci15zpjLf0I2t
        KJM/3Z/N4fLHB0rirtgnjro=
X-Google-Smtp-Source: ABdhPJwZHL2rfGXtcm26Me04W5/sadNXa1wrwI8Vuqr+7SPiZT2j0/nC4PRpqJdG4GZlGeLgXWx4OA==
X-Received: by 2002:ac2:5f04:: with SMTP id 4mr1076433lfq.140.1593157013884;
        Fri, 26 Jun 2020 00:36:53 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id s20sm6195817ljs.36.2020.06.26.00.36.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 00:36:52 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1joiuv-0005Dl-GU; Fri, 26 Jun 2020 09:36:58 +0200
Date:   Fri, 26 Jun 2020 09:36:57 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Phu Luu <Phu.Luu@silabs.com>
Cc:     "johan@kernel.org" <johan@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Brant Merryman <Brant.Merryman@silabs.com>,
        Richard Hendricks <Richard.Hendricks@silabs.com>,
        "hungnd3@fsoft.com.vn" <hungnd3@fsoft.com.vn>,
        =?utf-8?B?UGjDuiBMxrB1?= An <luuanphu@gmail.com>
Subject: Re: [PATCH v3 1/2] USB: serial: cp210x: Enable usb generic
 throttle/unthrottle
Message-ID: <20200626073657.GO3334@localhost>
References: <57401AF3-9961-461F-95E1-F8AFC2105F5E@silabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57401AF3-9961-461F-95E1-F8AFC2105F5E@silabs.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 04:22:58AM +0000, Phu Luu wrote:
> From: Brant Merryman <brant.merryman@silabs.com>
> 
> Assign the .throttle and .unthrottle functions to be generic function
> in the driver structure to prevent data loss that can otherwise occur
> if the host does not enable USB throttling.
> 
> Signed-off-by: Phu Luu <phu.luu@silabs.com>
> Signed-off-by: Brant Merryman <brant.merryman@silabs.com>

Almost there. As I mentioned, the authori's SOB goes first and the
following SOB lines indicates who forwarded the patch (e.g. you in this
case).

If you also contributed to the patch you (e.g. you added the missing
changelog text) you should also add a Co-developed-by tag as described
in the process document I referred to:

	Co-developed-by: states that the patch was co-created by
	multiple developers; it is a used to give attribution to
	co-authors (in addition to the author attributed by the From:
	tag) when several people work on a single patch.  Since
	Co-developed-by: denotes authorship, every Co-developed-by: must
	be immediately followed by a Signed-off-by: of the associated
	co-author.  Standard sign-off procedure applies, i.e. the
	ordering of Signed-off-by: tags should reflect the chronological
	history of the patch insofar as possible, regardless of whether
	the author is attributed via From: or Co-developed-by:.
	Notably, the last Signed-off-by: must always be that of the
	developer submitting the patch.

	- Documentation/process/submitting-patches.rst

So in this case the tags should probably be:

	SOB: Brant
	CDB: Phu
	SOB: Phu

Care to fix that up in a v4 (yes, please increment the patch revision
every time you resubmit)?

Johan

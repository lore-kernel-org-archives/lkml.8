Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A9EFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65E4D2073E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 07:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592984587;
	bh=aKUc7mLkB/DtscoCcedtjGBeQLGlJjcJimYQgEW7w8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=NcRkkKaIHH5ZqNzCiT70jQuEI/q6SUcWn6yn3pE45QY6JygJ6lc7onuktWbD31uVl
	 eJKj9Yy0bpBNBtKxdIDEKKMv2sMA2ks0O99/tsxh9/Reprq269Frt+fBfYOJForxE0
	 DRIhRle+7bxFP/reCdr2ynTDc/GfqpIjixrc/1yI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389964AbgFXHnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 03:43:05 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44817 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389583AbgFXHnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 03:43:04 -0400
Received: by mail-lj1-f196.google.com with SMTP id s9so1456719ljm.11;
        Wed, 24 Jun 2020 00:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jhPbD8Aqt3VIAAC9sQbp6H6U14unZ71zHne68ocC/q8=;
        b=X8meVbsgno95669OX3jLgN67LcAsyQkIf+vPBmMNiGqZ+uUdrr8l98DJo5DO3PqniI
         yqKWYnxyRmN/P/YrDhenWa/G5jbrykaS5hMkNwPwbQAMV/S7OGaKO6nEfsZCoCQH2o5Q
         xtGysK03/EPbxCbFwclQOsIKJzvCJA4r/kT9I0Vh+LmXW2P9c0iX3Fw62zWvOIs79K8n
         J+MBHB1EFKPHmuetw+pYxvr3ulmgn+4H760q3fOTSYcXkb7MJfSLRhulrreRiBXrJI+o
         YsA4USvW3f0qiX7BecSMZm/31JExVI6rJtNIyfY7YvJkQ71he9ndb3sDcfxxy7cKXmaj
         ongg==
X-Gm-Message-State: AOAM5316WSSj+o3poUeZbjbVaUegtU4WPtYwnzbRv6Ju54CRXVC1Gogh
        dsAAETrwp6wONXA/pA/r1W4=
X-Google-Smtp-Source: ABdhPJzB8lqg/UhFq6nJm/tBaxRhPTP8eEwYfojgTJmfjg6hV+eiXCF6eCfrgqxE5qiR3xNi3+afUw==
X-Received: by 2002:a2e:8041:: with SMTP id p1mr12780604ljg.99.1592984581669;
        Wed, 24 Jun 2020 00:43:01 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id i8sm4516783lja.18.2020.06.24.00.43.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 00:43:00 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1jo03i-0002Xx-SK; Wed, 24 Jun 2020 09:43:02 +0200
Date:   Wed, 24 Jun 2020 09:43:02 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Phu Luu <Phu.Luu@silabs.com>
Cc:     "johan@kernel.org" <johan@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Brant Merryman <Brant.Merryman@silabs.com>,
        Richard Hendricks <Richard.Hendricks@silabs.com>
Subject: Re: [PATCH v3 1/2] USB: serial: cp210x: Enable usb generic
 throttle/unthrottle
Message-ID: <20200624074302.GK3334@localhost>
References: <DM6PR11MB28578CA6D09D13A07D7959D99C950@DM6PR11MB2857.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR11MB28578CA6D09D13A07D7959D99C950@DM6PR11MB2857.namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 07:01:33AM +0000, Phu Luu wrote:
> Assign the .throttle and .unthrottle functions to be generic function
> in the driver structure to prevent data loss that can otherwise occur
> if the host does not enable USB throttling.
> 
> Signed-off-by: Phu Luu <phu.luu@silabs.com>
> Signed-off-by: Brant Merryman <brant.merryman@silabs.com>

One last form issue (besides the whitespace corrupted patch 2/2 that
Greg pointed out): The SOB tags records how a patch got into the
kernel (e.g. who forwarded it) and the first SOB should generally be the
author's.

In this case, I guess Brant is the primary author as he submitted these
patches last time around. If so, you need to manually add From line at
the beginning of the mail (i.e. before the commit message). If you use
git-format-patch, git would handle that for you.

You can also use the newish "Co-developed-by" tag to indicate joint
authorship. More details can be found in 

	Documentation/process/submitting-patches.rst

Johan

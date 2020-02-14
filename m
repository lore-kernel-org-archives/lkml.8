Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AAEAC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 08:02:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26273222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 08:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581667378;
	bh=qmQB2yFBUXA89Qa4bwZkEVyfHehqqrvLSydrY0xEkoI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aV3yXP8awSESWiRjhT5IXFuFcp6g6Tl75vCza9v5fNcRUzv8YzZlyQ98CKOWFdcXs
	 90MAYkjDReztv5DOr/qcYTyXB61mnVstCmUUDA8bXwWRplDXMLC6uaHTe9QHiFlQIB
	 hcsLhYG/dz0W8WIWbRdItahgLzKsRvifjppjAOYw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbgBNIC5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 03:02:57 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40049 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbgBNIC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 03:02:57 -0500
Received: by mail-lj1-f193.google.com with SMTP id n18so9668929ljo.7;
        Fri, 14 Feb 2020 00:02:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X/Md7A4NWERfg/DmbYpJ9Eml/ssX4Y/ElFMjdppGM4M=;
        b=KlL1ZtWClcHIDFbzzFBz94TxeIItpZ8QwO1r0YSV2TvIVpsgyaB7k+Dw1nZWg5eeDU
         V5VF0Qcn5DZtUeHjS6HPVLf5vZlz/VNfQmwlCbk9W5jRyKTPMYBt5szHL+yVnJt3txPA
         MlHwq32RRJCu7wvpjjcKaYu5qUfw5pOsdRg5gpglptWEDZ08/nFv6N4UITx2P06C/m0J
         z2AX8K6iPdEne7MV0fuwh/vJQ8p/ffmXKzccssM6aEVrvNVHKb6LogKXpi690sEBsCRm
         zl/XUdjRARsNQzBfkOVYp5h76u4r7xhuFxhWaROTpUg7lcW7m6Xx2r272113DIpJr7Oe
         JLWQ==
X-Gm-Message-State: APjAAAXmMKOqrR/83ITi1xZ5qnGZEvTQGJtMTXZZZSETKJ1/065GMf9b
        CooZDx2oyjbuoAnZKWVux7pNazww
X-Google-Smtp-Source: APXvYqxUWUc/YS4R459CfAbRFyrbZAk6ScEkay8bCr28k7SuiabEqUbiPHRXPG8OGsVnYE3CRVj94g==
X-Received: by 2002:a2e:9596:: with SMTP id w22mr1196873ljh.21.1581667374794;
        Fri, 14 Feb 2020 00:02:54 -0800 (PST)
Received: from xi.terra (c-12aae455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.170.18])
        by smtp.gmail.com with ESMTPSA id h24sm3043580ljl.80.2020.02.14.00.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 00:02:54 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1j2Vw6-0002Yp-GC; Fri, 14 Feb 2020 09:02:54 +0100
Date:   Fri, 14 Feb 2020 09:02:54 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sean Young <sean@mess.org>, Hans Verkuil <hverkuil@xs4all.nl>,
        linux-media@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH 0/6] media: fix USB descriptor issues
Message-ID: <20200214080254.GK4150@localhost>
References: <20200103163513.1229-1-johan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200103163513.1229-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 03, 2020 at 05:35:07PM +0100, Johan Hovold wrote:
> This series fixes a number of issues due to missing or incomplete sanity
> checks that could lead to NULL-pointer dereferences, memory corruption
> or driver misbehaviour when a device has unexpected descriptors.

> Johan Hovold (6):
>   media: flexcop-usb: fix endpoint sanity check
>   media: ov519: add missing endpoint sanity checks
>   media: stv06xx: add missing descriptor sanity checks
>   media: xirlink_cit: add missing descriptor sanity checks
>   media: dib0700: fix rc endpoint lookup
>   media: iguanair: fix endpoint sanity check

Just sending a reminder about these as it seems only the last one has
made into mainline (and stable) yet.

Johan

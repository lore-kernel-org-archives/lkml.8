Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310D0C10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 08:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC844208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 08:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583915800;
	bh=YYtQkcvWF1e+/AAYxtZFP70G9SXWzMfru0YI8OcLILc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Sg9G3SJqbgziEI4r804SearNfbQ5gbuPbyADrkrEctil874TphakzClSpbHg4ah1h
	 3cTF7TR5j1X56Bw/fhHGkyU3++T1iU3VVV8VnxDr3vTGxNm6FBC2r8itCmtOsZf6hs
	 c06wzy6BvGuviPNU8oMn+VSv8Pf/38EVUWcbkmro=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728897AbgCKIgj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 04:36:39 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:42278 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728889AbgCKIgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 04:36:37 -0400
Received: by mail-lf1-f66.google.com with SMTP id t21so931703lfe.9;
        Wed, 11 Mar 2020 01:36:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nxsT/Pc8YS3W4ZZbR+LaSW4I86pvWwbfPSU1ExyyG6U=;
        b=nbEVRocpIJP8LvofR0LPbJO/aPK5j9qOTaGBU7WHAxNAHVpQYBqpLYrCKNfE3wClj9
         JgiY+QCg6hAS//NiNj6rt48hpWGdoO3JDw6+EpmfUFJxR5R9fzaIwvdIA/d3Aq3L5Tgq
         DnW+fxbGGN3DFXGbysnBe69XEq+fJ3DP7rLp2TtranOz8lhoEUid2b9oSi6MkwAHvswl
         9t/YlLycGXsOnwxy7nWqFsP9vJflnDoC3cVeuMP2o2csclmBPIX5xP6QroldYIWruWlb
         APwaKR6nyXGDWMAwp8ar/lfgJbMvuugTnM6BNopk/KJuIlfQV979RkDCzkDl/HoF8aS2
         eV9g==
X-Gm-Message-State: ANhLgQ3hiswKEZ9I0jVQ9pGZO7LCmjMgTcDU1H+uoMOYY0PYPxKBhIxW
        ta00htN0Wdv4Eb1iEsFi1RI=
X-Google-Smtp-Source: ADFU+vu8cHvztLldR7/bpVxcHh3+auPWWweHqV0Ar/pwg2Az9cV9+LLhqwFEXQ3cj3dcSEtIgP3V8Q==
X-Received: by 2002:a19:fc15:: with SMTP id a21mr1513099lfi.78.1583915795890;
        Wed, 11 Mar 2020 01:36:35 -0700 (PDT)
Received: from xi.terra (c-12aae455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.170.18])
        by smtp.gmail.com with ESMTPSA id f10sm11433323ljn.44.2020.03.11.01.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 01:36:35 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.92.3)
        (envelope-from <johan@kernel.org>)
        id 1jBwqk-00012M-RT; Wed, 11 Mar 2020 09:36:22 +0100
Date:   Wed, 11 Mar 2020 09:36:22 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Scott Chen <scott@labau.com.tw>
Cc:     young@labau.com.tw, jocelyn@labau.com.tw, larsm17@gmail.com,
        Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] USB: serial: pl2303: add a new PID for HP
Message-ID: <20200311083622.GF14211@localhost>
References: <20200311061423.20686-1-scott@labau.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311061423.20686-1-scott@labau.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 02:14:23PM +0800, Scott Chen wrote:
> Add a device id for HP LD381 Display
> LD381:   03f0:0f7f
> 
> Signed-off-by: Scott Chen <scott@labau.com.tw>
> ---
>  Changes in v2:
>   - keep HP entries sorted by PID

Thanks for the update. Now applied.

Johan

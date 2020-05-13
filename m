Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856C2C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 23:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 763D72054F
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 23:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20150623.gappssmtp.com header.i=@ndufresne-ca.20150623.gappssmtp.com header.b="IDTCvW/h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732746AbgEMXig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 19:38:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732523AbgEMXif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 19:38:35 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92229C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 16:38:35 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b6so1229016qkh.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 16:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=gXX/nwUhWX5Ah6+4F5B0DqfcQzEJjwlK8RQjDyFdkkw=;
        b=IDTCvW/h15nfvqhHfob9E+czlTHbAFdazhK0hjKukexcmuenAmDFnJg1UoJW7KyurL
         CVJqdKa8QR/aRWlPMccAbqKCLUib954fp9xaRtsBnmy+K284h34GyaYQ8uPDbdGwUaHa
         FHy6snYwlWiAL5oKoLO1InN+p2u0w+ZMwi8otHVMyx+3aIgEV+4n4PYAFAVRalVpk5IH
         CO97cb9WSypDXjvdL5TocfDreScUhjcPcgY3oVIIgL/t7p7XSFQNXlaAgmUB07sHIX1f
         c8IwDZB/B7Z1ihqEOpc7N0Zwgd/2Nob4GJYvmTudsLePuAPIux4PNemN8ei7P8P9LGPr
         R/AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=gXX/nwUhWX5Ah6+4F5B0DqfcQzEJjwlK8RQjDyFdkkw=;
        b=jAjfiSkEJIJgKh4AnfSSt5YCMFl3pdg/FN+H2aV1WMV4zXM9PXbcjDhFUMBHqqM3Ho
         TUSV8sy7AO2udBOKDQ6rlYYuq+/z1fWADQx1e8oS/Yl2eTrqQw2Xro45cGiLQLzlfDSr
         DIZoScK4OSrxH+/vClhUPfYfrGa3e0IptAnshKCHnigpi6wTzobWoqqQ7B0Y0iJR8Zl4
         Q4Tf7ot+d735gdfj45xjBZlBtaSMio2rDHyMu4GFOUN374Yz8+dycrSDgwnXXXVyo7s7
         YmgtWaG1tg+CYPWSSXShtAZ6Idsh3Ss/ba0HM90qxWqxL4quCGHQ/Xj3a4KTgKZU6tZS
         ReMQ==
X-Gm-Message-State: AOAM5330oyR96IRaIHwzTUMlvZ40Yy18L5pu2dRLe6U17C0m5F1hnBh0
        1HypIkbgGRrYDdQmAOVJDJbzEg==
X-Google-Smtp-Source: ABdhPJzd/lwwcWhuSA6CCvJywL/X0Z4NV50aTy2l6Sg9uvPjGXI626hmPK4B2VCEGG3fDbtl86XIgg==
X-Received: by 2002:a05:620a:1472:: with SMTP id j18mr2011402qkl.363.1589413114645;
        Wed, 13 May 2020 16:38:34 -0700 (PDT)
Received: from skullcanyon ([192.222.193.21])
        by smtp.gmail.com with ESMTPSA id y21sm1154975qkb.95.2020.05.13.16.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 16:38:33 -0700 (PDT)
Message-ID: <b7122cb49cfa0bcfa433c154f6cb64ee0dba55da.camel@ndufresne.ca>
Subject: Re: [PATCH v3 1/3] media: rkvdec: Fix .buf_prepare
From:   Nicolas Dufresne <nicolas@ndufresne.ca>
To:     Ezequiel Garcia <ezequiel@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel@collabora.com, Jonas Karlman <jonas@kwiboo.se>,
        Heiko Stuebner <heiko@sntech.de>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Alexandre Courbot <acourbot@chromium.org>,
        Jeffrey Kardatzke <jkardatzke@chromium.org>,
        Gustavo Padovan <gustavo.padovan@collabora.com>
Date:   Wed, 13 May 2020 19:38:32 -0400
In-Reply-To: <ac6e162a24a8e2b2180b1a743e5ecd9a2023ac65.camel@collabora.com>
References: <20200505134110.3435-1-ezequiel@collabora.com>
         <20200505134110.3435-2-ezequiel@collabora.com>
         <CAAFQd5AWZFoPk2YTp2k8M7LvJshxw46-z+wK2VoM9EzB2CqiFA@mail.gmail.com>
         <c29fcc922a4917ac695043e605973ba9649f9c9b.camel@collabora.com>
         <CAAFQd5A458E8iqwakKTDEyTHC+NYY-M1SaTS3m0MARwPaRyOuw@mail.gmail.com>
         <ac6e162a24a8e2b2180b1a743e5ecd9a2023ac65.camel@collabora.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2 (3.36.2-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mardi 05 mai 2020 à 11:27 -0300, Ezequiel Garcia a écrit :
> On Tue, 2020-05-05 at 16:05 +0200, Tomasz Figa wrote:
> > On Tue, May 5, 2020 at 3:59 PM Ezequiel Garcia <ezequiel@collabora.com> wrote:
> > > On Tue, 2020-05-05 at 15:56 +0200, Tomasz Figa wrote:
> > > > Hi Ezequiel,
> > > > 
> > > > On Tue, May 5, 2020 at 3:41 PM Ezequiel Garcia <ezequiel@collabora.com> wrote:
> > > > > The driver should only set the payload on .buf_prepare
> > > > > if the buffer is CAPTURE type, or if an OUTPUT buffer
> > > > > has a zeroed payload.
> > > > 
> > > > Thanks for the patch. Just one question below.
> > > > 
> > > > Where does the requirement to set OUTPUT buffer bytesused to sizeimage
> > > > if the original bytesused is 0 come from?
> > > > 
> > > 
> > > If I'm reading english correctly, it's here:
> > > 
> > > https://www.kernel.org/doc/html/latest/media/uapi/v4l/buffer.html
> > > 
> > > """
> > > The number of bytes occupied by the data in the buffer. It depends on the negotiated data format and may change with each buffer for compressed
> > > variable size data like JPEG images. Drivers must set this field when type refers to a capture stream, applications when it refers to an output
> > > stream. If the application sets this to 0 for an output stream, then bytesused will be set to the size of the buffer (see the length field of this
> > > struct) by the driver. For multiplanar formats this field is ignored and the planes pointer is used instead.
> > > """
> > 
> > Okay, thanks. I wonder if this shouldn't be handled by the core,
> > though. Especially given that the document refers to the length field
> > specifically and not the sizeimage set in the format.
> > 
> 
> Yes, either core or helper, this definitely calls for a generic solution.

For the context, this is for backward compatibility. I'm not certain it
make sense for new driver interface like RKVDEC. Specially that if the
user did pass an empty buffer by accident, this will push garbage into
the driver. That being said, it seems to match the spec.

> 
> Ezequiel
> 


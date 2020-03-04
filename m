Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24943C3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 14:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1A7E2146E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 14:55:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Esxzr0Kp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbgCDOzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 09:55:53 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27960 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725795AbgCDOzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 09:55:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583333752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oKVK8TwDwaGEB6ayUlSBTUyLsbqiCprj+fuuCbfWt8c=;
        b=Esxzr0KpeR/IocQXzEUbf4FMwF4GXsbbc1UF8Wct6OHMhKqs8IlcMou50JQRDtm3BXWmnm
        ey/vPdy9m2XkupN4orBCBcMgOV0619COR8uGqorpzY8gF/Hff4/CUh0KEbIvtQp+UpkF/i
        7UEA6bdF6u/UAIg9zumhUHZn+F29a00=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-uNPoRVoHOvSry-xsE3xqTg-1; Wed, 04 Mar 2020 09:55:46 -0500
X-MC-Unique: uNPoRVoHOvSry-xsE3xqTg-1
Received: by mail-qv1-f71.google.com with SMTP id d7so1116688qvq.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 06:55:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oKVK8TwDwaGEB6ayUlSBTUyLsbqiCprj+fuuCbfWt8c=;
        b=KqthijX8pCkaBvdKlzLTlJOlPSycOR6c/kZ+ekojg6kUKugJGSlUU17XeXv9ZURBsF
         PnN7Apg7jNddVgPCqohCVIGhrcEJaEd1jM8uWPUnNAOnxBzB/C/qixHZ3uj4xMdTdDgE
         LUoYUMsltlm8EgCZQP8SA6xalmYCPke+/+q3YxR5bgibeuPdhNgPHd3ISLJ6DfXHtQOe
         1HZVKQKt5C0qP4/mQoMwrcvY85XNbNBs0Uh8oZ/MmQgYD3VioDbeZyXnqI7RgiUMtfsI
         6FZGqtnotoO1et+3R9v92Ku5huTrROqPnFwer2Fr4od2sa1ZhwWs1ZOGH53pQaxphldQ
         K6ng==
X-Gm-Message-State: ANhLgQ0Wfmg3wvH/3mZs38R5Ddor+0pyysZS9RJiIUSeNSg+jKh45mVO
        wE69qXNPZ6AQgei5kD1vyUn0Rxwlo0Dre3DEEo6GNabFm74tvtPjlp4bb3U1ZXINS1U9EOrADWA
        Pafmn2s4h626JMDSSKvyP9EuD5jSFdssTKxdrytWz
X-Received: by 2002:a05:620a:1517:: with SMTP id i23mr3121564qkk.459.1583333746201;
        Wed, 04 Mar 2020 06:55:46 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsCAa2/9q1HqrDGCRKmEqLJ4HJoEC8U/Z96fo7d9Ti23/A7BUH/Rq0FcHkVHybbcOgLpahxaE1ZwaDldnelFJ8=
X-Received: by 2002:a05:620a:1517:: with SMTP id i23mr3121533qkk.459.1583333745910;
 Wed, 04 Mar 2020 06:55:45 -0800 (PST)
MIME-Version: 1.0
References: <20200229173007.61838-1-tanure@linux.com> <CAO-hwJJDv=LnOQDbgWwg2sOccM9Tt-h=082Coi0aYdwG-CG-Kg@mail.gmail.com>
 <20200302120951.fhdafzl5xtnmjrls@debian> <20200304144858.xc6ekcvbzrhbggsc@debian>
In-Reply-To: <20200304144858.xc6ekcvbzrhbggsc@debian>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Wed, 4 Mar 2020 15:55:34 +0100
Message-ID: <CAO-hwJ+-xZgiNhOcRo1k3hGQxxkPd2RVrAbA3Gq1P28h7M1gdA@mail.gmail.com>
Subject: Re: [PATCH] HID: hyperv: NULL check before some freeing functions is
 not needed.
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Lucas Tanure <tanure@linux.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Jiri Kosina <jikos@kernel.org>, linux-hyperv@vger.kernel.org,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 4, 2020 at 3:49 PM Wei Liu <wei.liu@kernel.org> wrote:
>
> On Mon, Mar 02, 2020 at 12:09:51PM +0000, Wei Liu wrote:
> > Hi Benjamin
> >
> > On Mon, Mar 02, 2020 at 11:16:30AM +0100, Benjamin Tissoires wrote:
> > > On Sat, Feb 29, 2020 at 6:30 PM Lucas Tanure <tanure@linux.com> wrote:
> > > >
> > > > Fix below warnings reported by coccicheck:
> > > > drivers/hid/hid-hyperv.c:197:2-7: WARNING: NULL check before some freeing functions is not needed.
> > > > drivers/hid/hid-hyperv.c:211:2-7: WARNING: NULL check before some freeing functions is not needed.
> > > >
> > > > Signed-off-by: Lucas Tanure <tanure@linux.com>
> > > > ---
> > >
> > > Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> > >
> > > Sasha, do you prefer taking this through your tree or through the HID
> > > one. I don't think we have much scheduled for hyperv, so it's up to
> > > you.
> >
> > Sasha stepped down as a hyperv maintainer a few days back. I will be
> > taking over maintenance of the hyperv tree.
> >
> > The problem is at the moment I haven't got write access to the
> > repository hosted on git.kernel.org. That's something I will need to
> > sort out as soon as possible.
> >
> > In the meantime, it would be great if you can pick up this patch so that
> > it doesn't get lost while I sort out access on my side.
>
> Hi Benjamin
>
> I got access to the Hyper-V tree. I will be picking this patch up since
> I haven't got a confirmation from your side.
>

Great, thanks.

Sorry, I am pulled in freedesktop tasks right now that are a little bit urgent.

Glad you quickly set up the access rights.

Cheers,
Benjamin


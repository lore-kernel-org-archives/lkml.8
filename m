Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C014C34035
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 10:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 038A32173E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 10:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZK2NEwWO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726403AbgBRKkZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 05:40:25 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34794 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726199AbgBRKkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 05:40:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582022423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TdO6y8AHR+AaKNMW/gc1AonKG1Co8fKJjYOLG4b+LMk=;
        b=ZK2NEwWO7LhC7cNlQOmHTOay3zBYoAJTKgrGPmsaAkPtoXcfg3wqUY0trsRtdGLJG45DcB
        iG9OrtTnrjeq4SBbnKd8KYr2aHoAALAs4Y/aV924ARdfprLDPQAKdcQVtu95wI7q8X41vE
        WYEZ3KE/2Na45loYUnkr0HqG9a7uDK0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-LZ_QlZZSMG27vsZhuan82A-1; Tue, 18 Feb 2020 05:40:20 -0500
X-MC-Unique: LZ_QlZZSMG27vsZhuan82A-1
Received: by mail-qt1-f199.google.com with SMTP id l25so12810394qtu.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 02:40:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TdO6y8AHR+AaKNMW/gc1AonKG1Co8fKJjYOLG4b+LMk=;
        b=GCL3oo70hs2f/IRj63C/vfrFTsHBuCiSXuO0gqdlHDM1nTKD5dpoGZz9vlt0u9XaYJ
         fKMB/njg65ErYEJFmmibrS0HDa+wJL+vbTSCr4sXZLf6Z2BTQS3AMt2D84U5vDuNWQ7u
         HGcPea/G+JOZ3yNVawSz18MEto4fUkx8gJ/5eW15a1ilBL2wm5oGjlbv+3Of3wdu1hBV
         IId29Of5RXNk0+KO2T67SRBsmLd9dH1asXs0Kuwfb+RHY1zqzwjQWo9Wyn2S44DOuHA2
         8g/MlsE+ZPeG5b6azRsS9Q+czaSLfz3Dx2e9gqY5OvqaSRSMJNcuB0SNu+iaZxK0bn3R
         /u4g==
X-Gm-Message-State: APjAAAUy5SpgjRanQJAgni4d6HfSQYpswDg5sDG4bmeA3/eqememXMM3
        oxYwDIBfx5yq6vdWEKRfXUupnUsSyGm9TBH0W+5nDhPfJFg+1R4JIOHh3rKfG6zepKQf25tTCIT
        ypxAZbNxdqtur/6bg0gxBsZ6aH+dCHBnB/w7e+GV/
X-Received: by 2002:ac8:4914:: with SMTP id e20mr16568403qtq.199.1582022420169;
        Tue, 18 Feb 2020 02:40:20 -0800 (PST)
X-Google-Smtp-Source: APXvYqzop8HEVbMlqlTBReRnlW8cuV5OvmWmqddfFy0j/sJmV4q9d4HcrjMvRfW6D61qeuNc5yVz8c7y9clG60iT4W8=
X-Received: by 2002:ac8:4914:: with SMTP id e20mr16568385qtq.199.1582022419942;
 Tue, 18 Feb 2020 02:40:19 -0800 (PST)
MIME-Version: 1.0
References: <ae5eee33-9dfc-0609-1bf8-33fd773b9bd5@hanno.de>
In-Reply-To: <ae5eee33-9dfc-0609-1bf8-33fd773b9bd5@hanno.de>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 18 Feb 2020 11:40:09 +0100
Message-ID: <CAO-hwJJ1sc_RAh4ytWSOmRqfVESi2dvB_Ao_Vn+6XXixxVyxrA@mail.gmail.com>
Subject: Re: [PATCH 0/3] HID: hid-bigbenff: fixing three crash bugs in a
 gamepad driver
To:     Hanno Zulla <abos@hanno.de>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hanno,

On Mon, Feb 17, 2020 at 4:24 PM Hanno Zulla <abos@hanno.de> wrote:
>
> Hi there,
>
> the hid-bigbenff.c had three bugs causing possible kernel crashes.
>
> The first patch fixes a double free during device removal, which was
> caused by a wrong use of input_ff_create_memless(). The
> "driver-specific data to be passed into play_effect" parameter of
> input_ff_create_memless() would later be freed automatically when the ff
> device is removed. Since the driver also uses the managed resource API,
> it would automatically free the memory of this parameter twice, causing
> a general protection fault moments later.
>
> The second patch fixes the error path after hid_hw_start(), as a call
> to hid_hw_stop() is required in case of an error.
>
> The second patch also removes the hid_hw_close() call during device
> removal, as several other hid device drivers don't call this routine,
> either.
>
> The third patch adds a flag to avoid a race condition when there is
> still scheduled work left (or newly being scheduled) during or after
> device removal, which could cause a kernel crash.
>
> Thanks in advance for your review & kind regards,
>

I think the patches are correct (have you tested them with actual HW?).
However, checkpatch complains that the From and Signed-off-by email
differ. Can you send a v2 with a fix for that?

Cheers,
Benjamin


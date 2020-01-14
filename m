Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F71EC33CA9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 00:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D7EA2084D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 00:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qs995Vgt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbgANAtg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 19:49:36 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23571 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726494AbgANAtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 19:49:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578962974;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2l/F28QWuQvndxXiZazLaTDPrBDdV1YaH8Th1UuXAEQ=;
        b=Qs995VgtIwaXnRi+UyXEHdbXCjZCdl3ZWGmqy8obIGmhBCgXyVImFA+aF2+2Q+D+azFjsx
        YGjFbGf4xkUjXzMLWvjzWxbrdCSHCC1bMuNen46/YsrbJFD+yxGtyZIigYUnmChXGoboog
        EGQ5sGtVu5fQubaMkWuINw571VB74CE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-bgekvYNzOi-2su8ae3E4aQ-1; Mon, 13 Jan 2020 19:49:33 -0500
X-MC-Unique: bgekvYNzOi-2su8ae3E4aQ-1
Received: by mail-qt1-f197.google.com with SMTP id c8so7825619qte.22
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 16:49:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2l/F28QWuQvndxXiZazLaTDPrBDdV1YaH8Th1UuXAEQ=;
        b=HoA7vLFNhgp6C1Yo1iaYSw67etK7f73SezP1axhkX8XH/OaQqgKT+vyrjEOVRd7ww6
         TeSGykZbtstRMc/QruC2pWLldmKW+1dxPRs/W9XvpqUtPe6V6kGPylspY40lrYsfkMp5
         BzjgPQL2WlNIYzn5neZvCN2Cno8SLZU/gvFMvcsSXLljMAeqqcmJ2O1PJtvN/1o9Cnpx
         YNeISrOjCqS87PE0+ia/xLAXbqoyyiAPABGuYXliJMlb2huYXbOpufb+xkxB0VJCM73C
         Ow84omJcvEOsDFpwszyT6tC0pzSGFD3b+gW7TbUu6ih5tDAG5oPh4hwLgYWp9HbXVvdL
         92ew==
X-Gm-Message-State: APjAAAXZXtYAabtND/K1Bkw2cayAeZ43Ek8ZWK+ZcO4IYBh1yGsxZmoY
        905+7XGFbCBtC/uMl2zdVC03E4A9j28hy6dsiP0y3DpYSU+JxbtUG08fEwNiyYtW4JpoIGwIDpO
        n7Ofy+S5bavHNeVg0fXb6/z4O1jXjqYxLlM8LDZBp
X-Received: by 2002:ac8:478a:: with SMTP id k10mr1344572qtq.260.1578962972796;
        Mon, 13 Jan 2020 16:49:32 -0800 (PST)
X-Google-Smtp-Source: APXvYqyjxu5nBmZuS7sk+Evmp+4P+dIg5mfw0lvZthkPTRl3Bk9pdAQzlF5dtnuqpdGQwTqLJqW9VdkFG12KK27SFQI=
X-Received: by 2002:ac8:478a:: with SMTP id k10mr1344554qtq.260.1578962972518;
 Mon, 13 Jan 2020 16:49:32 -0800 (PST)
MIME-Version: 1.0
References: <20200112205021.3004703-1-lains@archlinux.org> <7d49a8444ea1740444d1e9133104530731bfb30a.camel@archlinux.org>
In-Reply-To: <7d49a8444ea1740444d1e9133104530731bfb30a.camel@archlinux.org>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 14 Jan 2020 20:48:17 +1000
Message-ID: <CAO-hwJ+56qUTr8HQOLyx9tgbJMuTTPbb6K40cwWnO=PzMcO+tQ@mail.gmail.com>
Subject: Re: [PATCH] HID: logitech-hidpp: add support for the Powerplay mat/receiver
To:     =?UTF-8?Q?Filipe_La=C3=ADns?= <lains@archlinux.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 1:31 AM Filipe La=C3=ADns <lains@archlinux.org> wro=
te:
>
> On Sun, 2020-01-12 at 20:50 +0000, Filipe La=C3=ADns wrote:
> > I also marked all lightspeed devices as HID++ compatible. As the
> > internal powerplay device does not have REPORT_TYPE_KEYBOARD or
> > REPORT_TYPE_KEYBOARD it was not being marked as HID++ compatible in
> > logi_hidpp_dev_conn_notif_equad.
>
> Actually I had another look at the code and I don't understand why we
> are manually setting |=3D HIDPP in
> logi_hidpp_dev_conn_notif_equad/logi_hidpp_dev_conn_notif_27mhz. We
> should set it in logi_dj_hidpp_event as it is triggered by receiving a
> HID++ packet.

long story short: nope :)

The whole purpose of setting the workitem->reports_supported is to be
able to create the matching report descriptor in the new virtual
device. So having this set in a callback will add an operation for
nothing every time we get an event, and will also not ensure a proper
separation of concerns.

Cheers,
Benjamin

>
> What do you think Benjamin?
>
> --
> Filipe La=C3=ADns


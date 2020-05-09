Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 635C7C47247
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 13:23:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EE5F206B8
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 13:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vv++posi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgEINXh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 09:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726942AbgEINXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 09:23:36 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C4DC05BD09
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 06:23:36 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id t16so1928559plo.7
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 06:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m6rH3XcvlCHD6Smk1GtwJfgqlq+VWlPnqoHpZdRsMeI=;
        b=vv++posiC5BPmZR4HWX8HS+TzniLdtAGuZFZDPbrPQo1073D3q/ECQEOkg1aMylGI1
         pWv+JD9zI9AJp/wNJqfhuYsc8R1lC7gLi+pl//nsy4vs0dEKOSB5xkpCrb8YUojJC5Vz
         6QbTBjWLt8wZG93KzYbQG5Kho2qq6trdt+humq28A4e0AkaRfZvkk6CTcntdGyl7oRXB
         6iWpykNJXNUNcPBZVSpbbPZTBlVFjgk5c5aohXtD/3SIaPwwsGPN3Vdv9e2iim7kDo0t
         U5hWGmQHtT2fyGK5ITs9NbkgqJG4B7WOxj9iy2UYJB5YHpyxJSVsj8PBX/9SU2M4g02q
         mtow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m6rH3XcvlCHD6Smk1GtwJfgqlq+VWlPnqoHpZdRsMeI=;
        b=t62ETK7z+9KFW+VkaI19/480HlL0eDMj0Tv9k51WIaoXtlwWbgpYDhzxXbpBvIkFRe
         /gs/tXVX9+JMdEwUbqWoc6xeB/FCUJjBa4CXO8ai4jLV11UAQdwC4m+fmFefMYpl7NMq
         huXsw8R6TCH2hvKGCFh9yXC2V6HrptQWSR1gLlL8AQau7nav+1WQRJBG2nfTWug9E+Yi
         /DF6ObeN8cM250pdTCSeehN9iHlBIFuaKQMdIoqFJ76DFOgbgG9BAKtY6S6bNke4VM63
         n245OfDEKLBnNgcp1n/zJndmxChcbYg5PY6EEtbJThwWdh5ImLZcmXwmAHu9zYpAyTNR
         0q0w==
X-Gm-Message-State: AGi0PubsDOUZdoTxKPUac0uLjNdW2gFMXfIQRXMrgMpEpocHCGMnKIux
        1VdQW7uZdGxyCkP74+lJqp/jeAiH+FtmXlhvxnKoZQ==
X-Google-Smtp-Source: APiQypLd3DqT21blgK/ByDCDeGLDE/yVcvXALGEMRPzDrr+O9dO+G6ZMeK8jNvsQSMWeSC/9purWjmLv/Y1njyvZz7c=
X-Received: by 2002:a17:902:4c:: with SMTP id 70mr6810872pla.336.1589030615938;
 Sat, 09 May 2020 06:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1588870822.git.andreyknvl@google.com> <459d02069dedefcc30095748f49ef4a426e15b74.1588870822.git.andreyknvl@google.com>
 <873689mtbv.fsf@kernel.org>
In-Reply-To: <873689mtbv.fsf@kernel.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Sat, 9 May 2020 15:23:25 +0200
Message-ID: <CAAeHK+zRcz8YH_r+QJVJzSgmC9aY57+COybOo60uR0GJTqfSUg@mail.gmail.com>
Subject: Re: [PATCH USB v3 3/5] usb: raw-gadget: fix gadget endpoint selection
To:     Felipe Balbi <balbi@kernel.org>
Cc:     USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 9, 2020 at 10:00 AM Felipe Balbi <balbi@kernel.org> wrote:
>
> Andrey Konovalov <andreyknvl@google.com> writes:
>
> > Currently automatic gadget endpoint selection based on required features
> > doesn't work. Raw Gadget tries iterating over the list of available
> > endpoints and finding one that has the right direction and transfer type.
> > Unfortunately selecting arbitrary gadget endpoints (even if they satisfy
> > feature requirements) doesn't work, as (depending on the UDC driver) they
> > might have fixed addresses, and one also needs to provide matching
> > endpoint addresses in the descriptors sent to the host.
> >
> > The composite framework deals with this by assigning endpoint addresses
> > in usb_ep_autoconfig() before enumeration starts. This approach won't work
> > with Raw Gadget as the endpoints are supposed to be enabled after a
> > set_configuration/set_interface request from the host, so it's too late to
> > patch the endpoint descriptors that had already been sent to the host.
> >
> > For Raw Gadget we take another approach. Similarly to GadgetFS, we allow
> > the user to make the decision as to which gadget endpoints to use.
> >
> > This patch adds another Raw Gadget ioctl USB_RAW_IOCTL_EPS_INFO that
> > exposes information about all non-control endpoints that a currently
> > connected UDC has. This information includes endpoints addresses, as well
> > as their capabilities and limits to allow the user to choose the most
> > fitting gadget endpoint.
> >
> > The USB_RAW_IOCTL_EP_ENABLE ioctl is updated to use the proper endpoint
> > validation routine usb_gadget_ep_match_desc().
> >
> > These changes affect the portability of the gadgets that use Raw Gadget
> > when running on different UDCs. Nevertheless, as long as the user relies
> > on the information provided by USB_RAW_IOCTL_EPS_INFO to dynamically
> > choose endpoint addresses, UDC-agnostic gadgets can still be written with
> > Raw Gadget.
> >
> > Fixes: f2c2e717642c ("usb: gadget: add raw-gadget interface")
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
>
> you're adding a new IOCTL, how is this a fix?

It's a fix in a sense that without this patch a user can't make
raw-gadget work with other UDCs besides dummy, and with this patch it
works (at least with dwc2 I'm currently using for tests).

I guess I could split this patch into two, one that removes the failed
attempt to auto-assign endpoints, and another one that adds the new
ioctl. Should I do that?

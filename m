Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEF1C2D0E9
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 19:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3082A206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 19:59:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqhFaSe+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbgCZT7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 15:59:00 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37416 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbgCZT67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 15:58:59 -0400
Received: by mail-ot1-f66.google.com with SMTP id g23so7314316otq.4;
        Thu, 26 Mar 2020 12:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ujm9KF63/2Xh115nBCNoaxnV0BjyE1MHL3TYCViqZyo=;
        b=dqhFaSe++a6/RkbeF44E988RrAbfGKW3JSkG4/6VsckRWU0SNkPkn4iw5X2HSvXHEe
         rLUYKAdYRHiiBS/zbJsmvoDCZAo2xI9K20gUOjkKKgPu1eHCzKVIsGq4rgZpWLixqPA2
         WMauF17ZmQUwEZf5zVkf1z9+4Z59P6IVRKSjWdSyp7KBFbkYrrUXWfJoa8suPju2X2Ms
         hqTzF1OVmxRqiWJGDNlh22gRoPRx6KSeDubBJJRUmUWt+xiVFYHnTF1xLlDPZOXLxhEa
         XTVHkTmO4UzXV/BI9Kk7zQVu64x9IaMRCdjfXu/fJTTZGgSGV9M2zyHaKhRO92kgpnr+
         gpig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ujm9KF63/2Xh115nBCNoaxnV0BjyE1MHL3TYCViqZyo=;
        b=SOOA+hNyE/+HyTKBf4UmLLef6nAf+WX+S2Wkom3+uc9GGm6DQVSFjRLe7+CXX2jvWa
         RpNTuJvr699tm7oNEkPZMy20DbUiYyG8ws/bABKoD8cX41nSFZf75YdF4rjxCs4jI6KF
         BL2IyqfNBvqUA/du8C0J96W6V5OMzJXuGyMcudFKmt2j3FbBxUryqkydItHxLWtwLotH
         nf5fDqDATRqJy0GRJoprjqt9RqKIKXJxNZ8TQLPeeYw7o8CCaICy6w3bXxf7XHsdr9dB
         BqjCYZ4jVytpdIYPzFr3rY4zy9OeOm09XAhdcxiwbFZeyQ2gzci1fZHOdyEZO2XUDBF+
         8n+A==
X-Gm-Message-State: ANhLgQ09E2lcIDCd3EzXID4q4/V2OZfzVsnpBL7Okkn0VyHiv2rjJRuo
        H+OzsTAicQJtjeNi0qs3qUg=
X-Google-Smtp-Source: ADFU+vtD4p8O/2ipfHSoS84IwgBiH+6D5rxYJYDtw8QWkpJ2ALLIJpe4Z27mKt4JLhHlETM7ETqxOg==
X-Received: by 2002:a9d:8d0:: with SMTP id 74mr7767203otf.39.1585252738620;
        Thu, 26 Mar 2020 12:58:58 -0700 (PDT)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id b26sm864123oti.3.2020.03.26.12.58.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 26 Mar 2020 12:58:58 -0700 (PDT)
Date:   Thu, 26 Mar 2020 12:58:55 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     Ashwini Pahuja <ashwini.linux@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Subject: Re: [PATCH] usb: gadget: udc: bdc: Remove unnecessary NULL checks in
 bdc_req_complete
Message-ID: <20200326195855.GB29213@ubuntu-m2-xlarge-x86>
References: <20191023002014.22571-1-natechancellor@gmail.com>
 <20200221045740.GA43417@ubuntu-m2-xlarge-x86>
 <CAKwvOdku24UV8J4uSKFFc7gmwOP28-8K352BJepb_z-octFoPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdku24UV8J4uSKFFc7gmwOP28-8K352BJepb_z-octFoPw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 01:42:57PM -0800, Nick Desaulniers wrote:
> On Thu, Feb 20, 2020 at 8:57 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > I know it has been a while but ping?
> 
> Sorry! Too many bugs...barely treading water! Send help!
> 
> >
> > On Tue, Oct 22, 2019 at 05:20:15PM -0700, Nathan Chancellor wrote:
> > > When building with Clang + -Wtautological-pointer-compare:
> > >
> > > drivers/usb/gadget/udc/bdc/bdc_ep.c:543:28: warning: comparison of
> > > address of 'req->queue' equal to a null pointer is always false
> > > [-Wtautological-pointer-compare]
> > >         if (req == NULL  || &req->queue == NULL || &req->usb_req == NULL)
> > >                              ~~~~~^~~~~    ~~~~
> > > drivers/usb/gadget/udc/bdc/bdc_ep.c:543:51: warning: comparison of
> > > address of 'req->usb_req' equal to a null pointer is always false
> > > [-Wtautological-pointer-compare]
> > >         if (req == NULL  || &req->queue == NULL || &req->usb_req == NULL)
> > >                                                     ~~~~~^~~~~~~    ~~~~
> > > 2 warnings generated.
> > >
> > > As it notes, these statements will always evaluate to false so remove
> > > them.
> 
> `req` is an instance of a `struct bdc_req` defined in
> drivers/usb/gadget/udc/bdc/bdc.h as:
> 333 struct bdc_req {
> 334   struct usb_request  usb_req;
> 335   struct list_head  queue;
> 336   struct bdc_ep   *ep;
> 337   /* only one Transfer per request */
> 338   struct bd_transfer bd_xfr;
> 339   int epnum;
> 340 };
> 
> So indeed the non-pointer, struct members can never be NULL.
> 
> I think the second check that was removed should be
> `req->usb_req.complete == NULL`, since otherwise `&req->usb_req` may
> be passed to usb_gadget_giveback_request which tries to invoke the
> `complete` member as a callback.  There are numerous places in
> drivers/usb/gadget/udc/bdc/bdc_ep.c that assign `complete = NULL`.
> 
> Can the maintainers clarify?

$ sed -n 537,555p drivers/usb/gadget/udc/bdc/bdc_ep.c
/* callback to gadget layer when xfr completes */
static void bdc_req_complete(struct bdc_ep *ep, struct bdc_req *req,
						int status)
{
	struct bdc *bdc = ep->bdc;

	if (req == NULL  || &req->queue == NULL || &req->usb_req == NULL)
		return;

	dev_dbg(bdc->dev, "%s ep:%s status:%d\n", __func__, ep->name, status);
	list_del(&req->queue);
	req->usb_req.status = status;
	usb_gadget_unmap_request(&bdc->gadget, &req->usb_req, ep->dir);
	if (req->usb_req.complete) {
		spin_unlock(&bdc->lock);
		usb_gadget_giveback_request(&ep->usb_ep, &req->usb_req);
		spin_lock(&bdc->lock);
	}
}

It looks like req->usb_req.complete is checked before being passed to
usb_gadget_giveback_request. So the patch as it stands is correct,
unless those checks needed to be something else.

Felipe, could you clarify or pick up this patch if it is correct? This
is one of two warnings that I see for -Wtautological-compare and I want
it turned on for 5.7 and it'd be nice to be warning free, especially
since I sent this patch back in October :/

Cheers,
Nathan

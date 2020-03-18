Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F78C5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 19:39:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F5E20724
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 19:39:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NIBoQtgG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgCRTjF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 15:39:05 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45481 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgCRTjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 15:39:05 -0400
Received: by mail-ot1-f68.google.com with SMTP id e9so19618776otr.12
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 12:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PvgEm6RZLQDuYhakUPnlpNqU4gW7bJUO0kvb30X68xs=;
        b=NIBoQtgG4Rp7/eDa7kyVrci5awvuzgt02DOA62uK23hLyncJyGafbxPXDT/btjz2hk
         /HgGbDhv6TiwFpodAsQL+SJB0BCVJilcsGTHNgfUl3sYcTxvFBv9lObHQt02CXC+kMgJ
         v6mkLOQEgV19lv95hEyL13/YxhCAh1ldF9KqwMMPa/xOuc6HykA44yFhon+553t/U05f
         QtSSoLtTPOlcgPflOqnAm/PGAfTezfz1WIjygAEZCeWzW8xmVvoRBqXxFn+lpj+zunUe
         JT9v9nYoyRmlV0R+/t/lSirZhCUXWHt2X+rXKSXiaUepH7Nb02UzPxB2je+AQ+f3Tk5G
         gwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PvgEm6RZLQDuYhakUPnlpNqU4gW7bJUO0kvb30X68xs=;
        b=M5vTE0WPRnDos8a4IVZPumitp3C5aSqQrr5dBghjpRr7G+4d3+cpFKpWpPoBuUdLpg
         oNZxMZ7xvuk1YOBjmhF5sWKwqTAE8eMK/GZWywHek37nG2odI/7srTI7ImI/a7mn4hU4
         vcEcjGjm02/83U6V+jqmedvyPhfoSLhzTVQpBP8hqwt5fwh8vAaMNwPUuDHtHLElYnOA
         sQZAB3M8BFGrdnPz+N6BCjXc0MOjU7l4ntb0YFtqzFOrFyWoLqvRFO30dg6i1hKvEIN5
         1rWYVOaY76eTlDBukiEHdSn3tlcy6qhlUnbB267PvqI+qK71van1XAI6OqWCN5cK67ro
         CBGg==
X-Gm-Message-State: ANhLgQ2isW+KEriuMGMYnNznK91g0icn4AQjYmNZ+TJ4G9NCM7b5mZlC
        kIu3oio4N3UCM7SCj5iWHGhUdNMxI7pyWb3+MRO0IA==
X-Google-Smtp-Source: ADFU+vu7pnwDal4gB09QFzfcR0/c2VxkCI04LsBk1AnrjZwLDwbyexqnHkz+YUKY4KMYKomA+dTyw9aoUggC+EmjWQU=
X-Received: by 2002:a9d:1920:: with SMTP id j32mr5032956ota.221.1584560344171;
 Wed, 18 Mar 2020 12:39:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200305054244.128950-1-john.stultz@linaro.org> <9ff7b615-8b8f-d3ba-e6f3-e3cee6ff58b2@codeaurora.org>
In-Reply-To: <9ff7b615-8b8f-d3ba-e6f3-e3cee6ff58b2@codeaurora.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 18 Mar 2020 12:38:53 -0700
Message-ID: <CALAqxLWdorO76ktNro8b11rQz3xsZpGpgcbYDxAhGK7NmBGJMA@mail.gmail.com>
Subject: Re: [RFC][PATCH] soc: qcom: rpmpd: Allow RPMPD driver to be loaded as
 a module
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Todd Kjos <tkjos@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 4, 2020 at 10:37 PM Rajendra Nayak <rnayak@codeaurora.org> wrote:
>
>
> On 3/5/2020 11:12 AM, John Stultz wrote:
> > Allow the rpmpd driver to be loaded as a module.
>
> The last time I tried this [1], I hit a limitation with pm_genpd_remove not cleaning up things right,
> is that solved now?
>
> [1] https://lkml.org/lkml/2019/1/17/1043
>

As I mentioned to Bjorn, I'll dig into this a bit to see if its
doable, but having it being a permanent/unloadable module is still an
improvement from it being stuck as a built in only.

thanks
-john

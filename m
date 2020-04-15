Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79FE3C3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EEAF20768
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:47:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MAXtbqkF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406375AbgDOTrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 15:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2405972AbgDOTrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 15:47:18 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DEEC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 12:47:18 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id m14so14577268oic.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 12:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cGqUHZ1cQgWuEpdLKBgrpNu2VBI6lZ/UbtgaGM3PR2w=;
        b=MAXtbqkFTbvJwV6W2Y8SVrGw4CxBTfaLZE+UiERljU3rMmKfHw/N7xAHpo2/33kP0F
         kGBTbsndHfwuH3XX3JaNtJUtRqGM6j/GxxoScSjvNjFUi+fIWtNvA5x9bqGeAWO5K6yE
         yuDNJD8zVx8u6egrlxWp4yRHVJXQtaUQocTKihaZrzzUrJltOgi1h8XcHR9O4aP7m+KM
         13U9pcY6tby2S9XQiFQiIZnA+dcv8mVTfK+Zgb3deitCxWtOIFHU6zbmHKyagTBC1rkF
         6Cb1I7vch+07zzM+4hoz9ozx+lRI4qmbmseWG37P7SZQvOeSlxEyiOpJ0exOtsWsnyQR
         BoNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cGqUHZ1cQgWuEpdLKBgrpNu2VBI6lZ/UbtgaGM3PR2w=;
        b=cdKP7S1RYK943bmxSAL+bsSzbpqrhD19X25JeIQ7IQXjRltLXKpt1gaIRALEtplNtQ
         fsr7ymEp96IytIe8efGXIHUy4PztIoNKfx8UNgeih5+Czu+yFjA2vmvtYEBVkZGiPHmU
         MGJkonoxpgr8WdEQxb5gveJk1dqG9zbvNBAY6AOuWpYH3ANDi7qe1PGzmuUKlL6RYpPk
         npJzlsRHuayu06SwDQsztjFQG6b9hWt1mTGzQTZ1xwngDssiysHVw5Vh/aaD7G2WTa/e
         bep4EQ+R++pT7Bgq+8fmPzg3epEsnM+scimM2ib3/yYxSuyN2BSJupzLQizZCxaCeo83
         PNIQ==
X-Gm-Message-State: AGi0Pub7+uB2ciLohn9rd6KzmdGPn69y6cq9AOfbfu7vTzfjJmZlQ4q1
        TxPtI4NGMFQy7pO/ZNFf8sw71nAipqvj6ywZer0pIg==
X-Google-Smtp-Source: APiQypKXI7b37OLv0UAGqZPbAP/72wlky4u0dZ2W2ausYN6VtWCeXqIUNN0w+EotFLyi5+S15sfQq5DdQ8mU707OOYo=
X-Received: by 2002:aca:c311:: with SMTP id t17mr608546oif.169.1586980037619;
 Wed, 15 Apr 2020 12:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200326224459.105170-1-john.stultz@linaro.org>
 <20200326224459.105170-3-john.stultz@linaro.org> <20200415182536.GX199755@google.com>
In-Reply-To: <20200415182536.GX199755@google.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 15 Apr 2020 12:47:06 -0700
Message-ID: <CALAqxLUvQRS0iFz5fXReXvY08oij1BtP6vpnL1qUY-Bs6OncnQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] soc: qcom: rpmh: Allow RPMH driver to be loaded as
 a module
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     lkml <linux-kernel@vger.kernel.org>, Todd Kjos <tkjos@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 11:25 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Hi John,
>
> with commit efde2659b0fe ("drivers: qcom: rpmh-rsc: Use rcuidle
> tracepoints for rpmh") the rpmh-rsc driver fails to build as a
> module:
>
> drivers/soc/qcom/rpmh-rsc.c:281:3: error: implicit declaration of function 'trace_rpmh_send_msg_rcuidle' [-Werror,-Wimplicit-function-decr]
>                 trace_rpmh_send_msg_rcuidle(drv, tcs_id, j, msgid, cmd);
>
>
> The problem is that the _rcuidle() functions are not generated for modules:
>
> #ifndef MODULE
> #define __DECLARE_TRACE_RCU(name, proto, args, cond, data_proto, data_args) \
>         static inline void trace_##name##_rcuidle(proto)                \
>         {                                                               \
>                 if (static_key_false(&__tracepoint_##name.key))         \
>                         __DO_TRACE(&__tracepoint_##name,                \
>                                 TP_PROTO(data_proto),                   \
>                                 TP_ARGS(data_args),                     \
>                                 TP_CONDITION(cond), 1);                 \
>         }
> #else
> #define __DECLARE_TRACE_RCU(name, proto, args, cond, data_proto, data_args)
> #endif
>
> Not sure what the best solution would be in this case. Having the macro
> define a dummy function for modules would fix the build error, however it
> would be confusing that the event is traced when the driver is built-in,
> but not when it is built as a module.
>
> I imagine the goal behind making this driver a module is to have a single
> kernel image for multiple SoC platforms, without too much platform
> specific code in the kernel image itself.
>
> I guess the question is whether there any options for keeping the driver
> modular and having consistent tracing behavior, short of removing the
> tracepoint.

Yea.  Stephen found that issue in -next last night once Bjorn added
the patches to his tree yesterday.

I've reached out to see if the restrictions on the trace_*_rcuidle
calls on modules is still necessary in this thread:
  https://lore.kernel.org/lkml/CALAqxLV4rM74wuzuZ+BkUi+keccxkAxv30N4vrFO7CVQ5vnT1A@mail.gmail.com/

For now, I suggested Bjorn revert the patch in his tree, and I'll try
to figure out an alternative solution to the trace call.

thanks
-john

Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B965DC10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 18:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F9420578
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 18:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LUFJKaI2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727687AbgCIST6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 14:19:58 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36243 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727667AbgCIST4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 14:19:56 -0400
Received: by mail-pl1-f193.google.com with SMTP id g12so4324844plo.3
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 11:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=P0TPxg5BSkLkFp0OlEKDiNJneMcG58MKCj4X0aj+r18=;
        b=LUFJKaI21+lFFDVRrC+d/G2PcPrZYvgqh+0oWuSPROHxW7Ea7z8UadjeAOplciaBz8
         X5EJXkfpuwXox4OXgu9iL+IJhvgbCazq00mu609wxGNv4KxblVbtut496ggXNd2yvNCs
         F5sZmlcQ5SgH1QEXcBsMeRlZZBgZjm+g9tqb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=P0TPxg5BSkLkFp0OlEKDiNJneMcG58MKCj4X0aj+r18=;
        b=EpkmBmXq0HNo2Ltecg6BcqoyzXtaRJCOl72bt+0nSq4txhftSkzshJjfjL2hfm3qHA
         pGB0nUN2YQTUd7H76Sk0zrk/0jne1Ma2sCjohPpneBBcrgBa2+RFIKwnYQDIn0URWqjN
         lvNvMzN9+4vqJz1Gu+Bu+SpM0eY16avFZNSCvWAPA4hSuMy7tH32S7ShshatUdLWmcY9
         jMJoTKgEE8tBgCiWnDFKgCISMMdH7eT0ad9S6LnCDPpc6BYlPyV5BM5RKnx3oG+nZciu
         MUmnbi3lT044sJ3lM5RlAOE0w8Z6FQ028vrDJ27k/IGY21JueUnYTeRu/7XN7EnonOqH
         f5NA==
X-Gm-Message-State: ANhLgQ2FxzhpA/5vUBHASws0qWZ3X6eOgf0M3niu+KgjVKHD5v2vIPQ4
        Nu9MJxw/k+sO0ijSqcVEwKq5dA==
X-Google-Smtp-Source: ADFU+vteH3EUGOgnDI/8G2cbcdr7iPU8YaxSDDMpRLpCXHo30kxiDLe9pP9m3jr4gYNbbsfAKqWLUA==
X-Received: by 2002:a17:902:904c:: with SMTP id w12mr17536870plz.35.1583777994619;
        Mon, 09 Mar 2020 11:19:54 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id p21sm16194246pff.91.2020.03.09.11.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 11:19:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <e1133bcd-b1fe-98b3-3a28-c12d07ff8ebc@codeaurora.org>
References: <1583479412-18320-1-git-send-email-mkshah@codeaurora.org> <1583479412-18320-3-git-send-email-mkshah@codeaurora.org> <20200307064231.GF1094083@builder> <e1133bcd-b1fe-98b3-3a28-c12d07ff8ebc@codeaurora.org>
Subject: Re: [PATCH v3 2/4] soc: qcom: Add SoC sleep stats driver
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     mka@chromium.org, evgreen@chromium.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        agross@kernel.org, dianders@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org,
        Mahesh Sivasubramanian <msivasub@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maulik Shah <mkshah@codeaurora.org>
Date:   Mon, 09 Mar 2020 11:19:53 -0700
Message-ID: <158377799320.66766.16447517220100414599@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maulik Shah (2020-03-09 03:58:27)
>=20
> On 3/7/2020 12:12 PM, Bjorn Andersson wrote:
> > On Thu 05 Mar 23:23 PST 2020, Maulik Shah wrote:
> >> diff --git a/drivers/soc/qcom/soc_sleep_stats.c b/drivers/soc/qcom/soc=
_sleep_stats.c
> >> new file mode 100644
> >> index 00000000..79a14d2
> >> --- /dev/null
> >> +++ b/drivers/soc/qcom/soc_sleep_stats.c
> >> @@ -0,0 +1,248 @@
[...]
> >> +    u32 pid;
> >> +};
> >> +
> >> +static struct subsystem_data subsystems[] =3D {
> >> +    { "modem", MODEM_ITEM_ID, PID_MODEM },
> >> +    { "adsp", ADSP_ITEM_ID, PID_ADSP },
> >> +    { "cdsp", CDSP_ITEM_ID, PID_CDSP },
> >> +    { "slpi", SLPI_ITEM_ID, PID_SLPI },
> >> +    { "gpu", GPU_ITEM_ID, PID_APSS },
> >> +    { "display", DISPLAY_ITEM_ID, PID_APSS },
> >> +};
> >> +
> >> +struct stats_config {
> >> +    unsigned int offset_addr;
> >> +    unsigned int num_records;
> >> +    bool appended_stats_avail;
> >> +};
> >> +
> >> +static const struct stats_config *config;
> > Add this to soc_sleep_stats_data and pass that as s->private instead of
> > just the reg, to avoid the global variable.
>=20
> No, this is required to keep global. we are not passing just reg as s->pr=
ivate,
> we are passing "reg + offset" which differs for each stat.

Can you please stop sending these review comment replies and then
immediately turning around and sending the next revision of the patch
series. I doubt that the changes take less than an hour to write and it
would be helpful for everyone involved to have constructive discussions
about the code if there's ever a response besides "done" or "ok".

In this case it should be possible to get rid of the global 'config'.
Make a new container struct to hold the config and offset or figure out
what actually needs to be passed into the functions instead and do that
when the files are created.

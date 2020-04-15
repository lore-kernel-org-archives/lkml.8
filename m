Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF8BFC3815B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB3A220774
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ac2G13fD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437878AbgDOT37 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 15:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2406962AbgDOT3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 15:29:46 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC04C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 12:22:49 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mn19so293307pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 12:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=2G6Ppm6S3yDtcLs073bFFvyTtzzj8G77IKge+inQALY=;
        b=Ac2G13fDGKHLvowWSXOVwAwAw5x1iFQyzhRdx7GF5kVg4aB5Phh8tEMuxboIKJqxHm
         B5cvqQA4u5O+sddhg4tyP6Eofl69zfR+4bNTUr6t0qV2CfbazBQeEYMJA2t+u0S5Bso0
         IEUFbEa+B8Cbv8q/pgnFhY5N8s2OfrG8ktMH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=2G6Ppm6S3yDtcLs073bFFvyTtzzj8G77IKge+inQALY=;
        b=q4cp+p2EGHm2WHgtBVthDFHZxyu0r+egWj6UT8RLpbw9fSeSg4xPenGGkEbINfRPvx
         NLs5W6RROPxv9dUhQlZQXgOkzaSBg3KCSUjxrj9OzaUMtTbNTGbJYKheQPixq81GxtaN
         1QuwJeavsCFTikYZnUTpbqAfAwoVhhu8G+YpgvMXn/Fv2Zw99s1tsQIZwbx9C/MZ2+0w
         n9PNj3XWu0njnIbhxks3l0JHIkupRfdsrPBG15h8IgTuBK6i8Q0iOV9nMOm4VDWFhbix
         6lcm5WE1VvArSxmsZB5/X8D1xZCeUp+O4HN2AASL82tHeeeWnsMMZQE/q2KzqDQfCU14
         SVQg==
X-Gm-Message-State: AGi0Puai+kGqy0iGwDS8NF93eSQgmrciGpiDpJnV5uhxdL1qeVB0etRs
        nuAO9RGHhVSRDOymXPytSnJRnw==
X-Google-Smtp-Source: APiQypLELTVr4j+fjkSgAB7n6Lhqk9TCQuapKh/6qd7zA4qgNHTPFw7PmI+jfp5rV5dcZFXg8gHcig==
X-Received: by 2002:a17:90a:df83:: with SMTP id p3mr891984pjv.66.1586978568434;
        Wed, 15 Apr 2020 12:22:48 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id x70sm14127677pfc.21.2020.04.15.12.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 12:22:47 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200415141754.GB3820@codeaurora.org>
References: <20200309185704.2491-1-swboyd@chromium.org> <20200414215015.GA3820@codeaurora.org> <158693222998.105027.13298557609451842017@swboyd.mtv.corp.google.com> <20200415141754.GB3820@codeaurora.org>
Subject: Re: [PATCH] soc: qcom: cmd-db: Add debugfs dumping file
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Maulik Shah <mkshah@codeaurora.org>
To:     Lina Iyer <ilina@codeaurora.org>
Date:   Wed, 15 Apr 2020 12:22:46 -0700
Message-ID: <158697856675.105027.14667274133002675067@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lina Iyer (2020-04-15 07:17:54)
> On Tue, Apr 14 2020 at 00:30 -0600, Stephen Boyd wrote:
> >Quoting Lina Iyer (2020-04-14 14:50:15)
> >> On Mon, Mar 09 2020 at 12:57 -0600, Stephen Boyd wrote:
> >> >+              seq_puts(seq, "-------------------------\n");
> >> >+
> >> >+              ent =3D rsc_to_entry_header(rsc);
> >> >+              for (j =3D 0; j < le16_to_cpu(rsc->cnt); j++, ent++) {
> >> >+                      seq_printf(seq, "0x%08x: %*pEp", le32_to_cpu(e=
nt->addr),
> >> 0x%05x is what we would have for a resource address.
> >
> >Sorry I totally missed this because the mail wasn't trimmed at all and
> >it was really hard to find the one line that wasn't quoted!
> >
> Sorry, my bad. Somehow didn't notice the quoting has changed.
>=20
> >5 vs. 8 sounds OK to me. Send a patch? Or I can do it if you prefer.
> Apart from the nit, I think the patch looks good. Feel free to add -
>=20
> Reviewed-by: Lina Iyer <ilina@codeaurora.org>
> Tested-by: Lina Iyer <ilina@codeaurora.org>

Cool thanks. I'll send a patch given that Bjorn has already picked it
into the qcom tree.

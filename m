Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364B6C54FD0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13E2C20736
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X9O/ERZj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbgDXR2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 13:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727089AbgDXR2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 13:28:34 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6F5C09B04A
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 10:28:30 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id f8so3982689plt.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 10:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=vbEqXfaL54AfhJ4npcAoZ7HbWa5wguFP+Av2lpKJi2A=;
        b=X9O/ERZj2xJ0YL55Nob0jzqnqFCgGKnwLhHbYF3mO+mgvWJRtcdT4uaKePsCLmwGXm
         Iz5UiY/PW+9jwH3jHHJsy9oR1cq0ynzGJAmtF800KvvyTqrkS2r8VWzooNp1+6tF4Gzr
         Y1BsaPD+l5mEYmgcPSW6Cmz19BO4kGl07GGoE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=vbEqXfaL54AfhJ4npcAoZ7HbWa5wguFP+Av2lpKJi2A=;
        b=MMaKE1vKV/Geq70RygX778H1vlMsXaI4IyWfIptxnL/xxaphhCAnV1b+Y3IvZBsbab
         fuEE1egaI6NI1ByDTrjgursEKMdzUetrBs76QsNTF+WQllnfporoFEA5Smx/bE6NuRp3
         1uDV2geQIIQLKJgH5neK0A6IGQxfzyEUkMIZlbNw4d+qvy3lxlyR6R413MiybnN8ahjS
         nFpJHnOdDhPilwY2ha0V6ZKlqYReJCEam66Sd1oe9clH4BVAwSKtlmX6wNW8x6xuxsTn
         PI8OSDzIqHr3w0qIVbD+CKh86c4rqmoDJy3gsdbcqQwH7sAdZWYk5QHQQLq9cFWGhE/Q
         e0SA==
X-Gm-Message-State: AGi0PuZqbCCaqAT5WlMDCR7VdaJkWNKu7icRj5UJPQ7z9eAcWJOaTYXb
        r5plc82BS+7+p7V0oYncqnYiww==
X-Google-Smtp-Source: APiQypLU3bzunfrfhJUL85QtiJqsJkujcGke3q5ieGkSoz15JrT2JAij9hhDu3DSOtgoCGO7hbW5Zg==
X-Received: by 2002:a17:902:a40f:: with SMTP id p15mr10746662plq.154.1587749310454;
        Fri, 24 Apr 2020 10:28:30 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id o68sm6336898pfb.206.2020.04.24.10.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 10:28:30 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAD=FV=WT1rw9H34GjQSjbubR6y61=v-jR-gEvRtN4tU_NwviHA@mail.gmail.com>
References: <20200424045414.133381-1-swboyd@chromium.org> <20200424045414.133381-2-swboyd@chromium.org> <CAD=FV=WT1rw9H34GjQSjbubR6y61=v-jR-gEvRtN4tU_NwviHA@mail.gmail.com>
Subject: Re: [PATCH 1/3] soc: qcom: rpmh-rsc: Remove tcs_is_free() API
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Maulik Shah <mkshah@codeaurora.org>
To:     Doug Anderson <dianders@chromium.org>
Date:   Fri, 24 Apr 2020 10:28:29 -0700
Message-ID: <158774930920.135303.8846586262429360001@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Doug Anderson (2020-04-24 10:12:04)
> On Thu, Apr 23, 2020 at 9:54 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > +       unsigned long i;
> >
> > -       for (i =3D 0; i < tcs->num_tcs; i++) {
> > -               if (tcs_is_free(tcs->drv, tcs->offset + i))
> > -                       return tcs->offset + i;
> > -       }
> > +       i =3D find_next_zero_bit(drv->tcs_in_use, MAX_TCS_NR, tcs->offs=
et);
>=20
> Rather than passing MAX_TCS_NR would it be legit to pass "tcs->offset
> + tcs->num_tcs"?  You are passing that as "size" above in
> check_for_req_inflight().

Yeah I think that should work. I'll roll it in.

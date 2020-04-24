Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539A8C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:21:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22F0A2075A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 17:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A5I4cJO7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbgDXRV4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 13:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbgDXRV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 13:21:56 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7927C09B048
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 10:21:55 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t4so3951239plq.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 10:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=9/rHi+opABqnWC7ABI/VwKKz8YnCgSS+xTfGsZR3+hI=;
        b=A5I4cJO7vbWtjiQHG/voDoJquzAhktDCzv2uPQSWugiA7YZ3veVmJWTQyyFxVvkH+h
         FvhxCh2f6rnnVTSTWupVspEx2HKhd4KZsDSKOhxYZ6rEz/aBxOprzXZA2eY0mAmDdgCb
         57fUF7mxZHyR8Du18R04UyVJ6pNRyYB5vrXwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=9/rHi+opABqnWC7ABI/VwKKz8YnCgSS+xTfGsZR3+hI=;
        b=AADGBeC0eYh/tl7HRJDu/UFTlnarwPKFUddN4TlFRr/19ZuiAowzh6/QeV0ifoQPtb
         styPqsh+GwI614yovz5AVg47LvWBk9urhta8dQYYu02hs844IOs4ma9TkiTDY/pZ6QNC
         t4o0ISurSZxBd9HHptVN1hyvtdYSbfiufbhwc8rdwtOFI6Jf9L4GlYUN7cEUXq2TBtYR
         WYDpVmKny6GE+v67anD6+1O8bTN27EG/q++lfEIDifFAjgbX7omijmYVi2rCFvOSKrkR
         alKQkzHagBofNY7cdw+yqnCXD9ZhkH7f3qKLlVwj8961/CBIZc8KDnewl2dHQz3NdcBL
         wlaQ==
X-Gm-Message-State: AGi0PuYgUmmGUuiZ0Lo9jwE/Zn0yQQ0uT8xqiAmrAdDfRw74NPWwvtly
        2K1cmsPx+wdkdrd8icnARaayog==
X-Google-Smtp-Source: APiQypK3MbrgY702ieZ2DMynzA3M5bEztwrT5ExeMwcuBzWd4TslsMOW4R0wW+GRnOwlzOqB9iaskg==
X-Received: by 2002:a17:902:441:: with SMTP id 59mr9971066ple.339.1587748915325;
        Fri, 24 Apr 2020 10:21:55 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id p10sm6433767pff.210.2020.04.24.10.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 10:21:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200424053626.GV20625@builder.lan>
References: <20200424045414.133381-1-swboyd@chromium.org> <20200424045414.133381-2-swboyd@chromium.org> <20200424053626.GV20625@builder.lan>
Subject: Re: [PATCH 1/3] soc: qcom: rpmh-rsc: Remove tcs_is_free() API
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Maulik Shah <mkshah@codeaurora.org>,
        Douglas Anderson <dianders@chromium.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Date:   Fri, 24 Apr 2020 10:21:53 -0700
Message-ID: <158774891388.135303.17625994744372966487@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2020-04-23 22:36:26)
> On Thu 23 Apr 21:54 PDT 2020, Stephen Boyd wrote:
> > diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> [..]
> >  static int find_free_tcs(struct tcs_group *tcs)
> >  {
> > -     int i;
> > +     const struct rsc_drv *drv =3D tcs->drv;
> > +     unsigned long i;
> > =20
> > -     for (i =3D 0; i < tcs->num_tcs; i++) {
> > -             if (tcs_is_free(tcs->drv, tcs->offset + i))
> > -                     return tcs->offset + i;
> > -     }
> > +     i =3D find_next_zero_bit(drv->tcs_in_use, MAX_TCS_NR, tcs->offset=
);
> > +     if (i > tcs->offset + tcs->num_tcs)
>=20
> Afaict this should be >=3D
>=20

Thanks!

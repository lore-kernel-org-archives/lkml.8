Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2022C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 03:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E79120855
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 03:09:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tHmAMAlh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbgHGDJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 23:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbgHGDJX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 23:09:23 -0400
Received: from mail-oo1-xc41.google.com (mail-oo1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598F7C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 20:09:22 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id o36so140321ooi.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 20:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U6N6/24JW1Y/fwXBodacBshH0kzzc0mjrkSIhSAOunI=;
        b=tHmAMAlhLR++RGcgqmMwLF46mP8giMmzW4D1mUiKGtdExH6GH+ypH27lMlGEP8MY8z
         AxlV7bL7pvqXGkfHsKJ29/sgUzIAvsTER0ZfCctrhGmzkOjYGxw50/O687X1jG/vWGsE
         Gzlrq+VtOwQQ8JJWdoeRFaJIQ41wYtmUb2/l8lxqeEqaIiDM/Aw+AENtNQQmICKv+XnA
         fSyzuIfdJTP2vgFjRRFrNRrCzruW3kdoy/XkwnymSmKR36gPR6oUuxmkmVorFWyybRqz
         Z1UvkvwkPWAyRp/TPnFCb5uD4w3riuTuC8Sv/msJQln9AES2Lgul1rg1vFz0kv9AiwXE
         Nceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U6N6/24JW1Y/fwXBodacBshH0kzzc0mjrkSIhSAOunI=;
        b=MBaTAs872ka6UqoHPGkSptBOpuK2CYtlq8DUJf5EXsyMADKKpZbAlqN7U0rGm+FPbZ
         EtFR1NAyc1C0jz4m7EHXRYwrk3cwuKcZNrI6dQcqoC4XNOe6uv8FmQVZtE3VYj1YrED2
         esAfX025Eo+3NcVFQCgmsNu+cHliYVgimSL+Alk0OgeFRAczxLFV81McNxwXFunuL8UE
         Dmu/KFdrlioMbu7YcJYc7JfdtH+g/ceez89eJw1kr3nOJHZnCQ9VSQC6NuIM+qcDovT7
         KNtmzrKgs04AuhUxP8DLVHk/gaMOrKbB8ZUezDmBe7mC1h3g1xZq6tOnAVj2a2RuqKmU
         PqAA==
X-Gm-Message-State: AOAM5335NrFf0HIXvHbduDz3NKBtpYkbwOkTGL6jEY0dgOmTUaTzifRS
        bj2rVbj+LZ/Foz+XWcZh2QDWT+NJ6lLrhICYQLQevA==
X-Google-Smtp-Source: ABdhPJziIq4CxdyB5vG+jRFUsHOHgL+P+hGyJHasj3L3ZJadah7L0e95Nkg0bjqc283OEZcDpuUPqtZE3AJU+sXVHmI=
X-Received: by 2002:a4a:ca11:: with SMTP id w17mr10792617ooq.88.1596769761749;
 Thu, 06 Aug 2020 20:09:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200718000637.3632841-1-saravanak@google.com>
 <20200718000637.3632841-3-saravanak@google.com> <CALAqxLVZ+rFE+hM9OtQ46NqpTHeLu6oKLNWKstLv1U5zbwyq7g@mail.gmail.com>
 <CAGETcx_rkK3-bKhDP_N4n_WyXLXFPoaUV9rbY_Y+H1Joj=dCyw@mail.gmail.com>
 <f314b687-11a9-5a5e-e79e-c46dd2f16c6f@kali.org> <78ad0914-6173-f753-9eba-b7cbfbb51fd6@kali.org>
 <CALAqxLXPN9kThwF32YoWyApaWnfjthANXj3uk65Wc3ddaJQFFQ@mail.gmail.com>
 <20200807004001.GF20825@builder.lan> <CALAqxLWwY00PVUL7EM-tgbXeB5h8MsfPo7EFZTfDSzbb3P3eqQ@mail.gmail.com>
 <20200807013903.GG20825@builder.lan> <CALAqxLWmJisTA9836Rvb8f9m4hsTL7iZ=HQtz39anu2Bbgv44g@mail.gmail.com>
 <CAGETcx9Gsa9CWow8MBVPF4cgofdcK1+cFohAf_-Dqa3JT8H1bw@mail.gmail.com>
In-Reply-To: <CAGETcx9Gsa9CWow8MBVPF4cgofdcK1+cFohAf_-Dqa3JT8H1bw@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 6 Aug 2020 20:09:10 -0700
Message-ID: <CALAqxLWR3mKrQDn5VkOV_zaaqxmwWzZwK0CCLRSfGJDU6WUXag@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] irqchip/qcom-pdc: Switch to using
 IRQCHIP_PLATFORM_DRIVER helper macros
To:     Saravana Kannan <saravanak@google.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Steev Klimaszewski <steev@kali.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Hanks Chen <hanks.chen@mediatek.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 6, 2020 at 8:02 PM Saravana Kannan <saravanak@google.com> wrote:
> On Thu, Aug 6, 2020 at 7:49 PM John Stultz <john.stultz@linaro.org> wrote:
> > On Thu, Aug 6, 2020 at 6:42 PM Bjorn Andersson
> > <bjorn.andersson@linaro.org> wrote:
> > > With all due respect, that's your downstream kernel, the upstream kernel
> > > should not rely on luck, out-of-tree patches or kernel parameters.
> >
> > I agree that would be preferred. But kernel parameters are often there
> > for these sorts of cases where we can't always do the right thing.  As
> > for out-of-tree patches, broken things don't get fixed until
> > out-of-tree patches are developed and upstreamed, and I know Saravana
> > is doing exactly that, and I hope his fw_devlink work helps fix it so
> > the module loading is not just a matter of luck.
>
> Btw, the only downstream fw_devlink change is setting itto =on (vs
> =permissive in upstream).

I thought there was the clk_sync_state stuff as well?

> > Also I think Thierry's comments in the other thread today are also
> > good ideas for ways to better handle the optional dt link handling
> > (rather than using a timeout).
>
> Could you please give me a lore link to this thread? Just curious.

Sure: https://lore.kernel.org/lkml/20200806135251.GB3351349@ulmo/

thanks
-john

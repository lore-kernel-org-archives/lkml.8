Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 932E0C33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 11:36:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FF152081E
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 11:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbgAMLgh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 06:36:37 -0500
Received: from mout.kundenserver.de ([212.227.126.134]:52849 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgAMLgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 06:36:37 -0500
Received: from mail-qt1-f179.google.com ([209.85.160.179]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Mw9Dg-1jgjEF2pOu-00s7De for <linux-kernel@vger.kernel.org>; Mon, 13 Jan
 2020 12:36:35 +0100
Received: by mail-qt1-f179.google.com with SMTP id k40so8754287qtk.8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 03:36:35 -0800 (PST)
X-Gm-Message-State: APjAAAUrWY4/wV9ALI1uGKEO7lxyZqON3rmMTmBAfW9JU6eBaBYglyhj
        2GhZa9mgTZOsIG9PDVAqZz7ZsCJOjFhiucLqbFI=
X-Google-Smtp-Source: APXvYqy4d5Y865StavZXLM6RVQnqg1jOobhsOc+SKK7Ta7Xbx6KIewCh7Nm3l9DGq6gktI9KWSqh+RU8fwyhDyVDD2g=
X-Received: by 2002:ac8:47d3:: with SMTP id d19mr13346118qtr.142.1578915394643;
 Mon, 13 Jan 2020 03:36:34 -0800 (PST)
MIME-Version: 1.0
References: <3f5567ec928e20963d729350e6d674c4acb0c7a0.1578648530.git.viresh.kumar@linaro.org>
 <CAK8P3a1MLyP4ooyEDiBF1fE0BJGocgDmO1f5Qrvn_W5eqahz8g@mail.gmail.com> <20200113064156.lt3xxpzygattz3he@vireshk-i7>
In-Reply-To: <20200113064156.lt3xxpzygattz3he@vireshk-i7>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 13 Jan 2020 12:36:18 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2u6s4MAM_9bOqSt5NwVc4XrXs9W36tp-7rWWTXx0+pRg@mail.gmail.com>
Message-ID: <CAK8P3a2u6s4MAM_9bOqSt5NwVc4XrXs9W36tp-7rWWTXx0+pRg@mail.gmail.com>
Subject: Re: [PATCH V2] firmware: arm_scmi: Make scmi core independent of
 transport type
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        cristian.marussi@arm.com, peng.fan@nxp.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:54glluQQTkTOIsQx4a7n9JsFZHg6zm9do6lRDjJ+aNvqLmyCHTM
 LXgAVAwmRFI26WQ9Kc7CgPf3HoSV4YvZo8KBSfY34AMopGj7Ihd9hYCE1rxmYcRF/RNR9T8
 LLC0wcLAdUj6QqQugIkLj+7FeXZp1/Diiob6taOeNvr09EgBqeQ/XZ8XhWDjDTjE80FXqqf
 r7+RGSY4vv3vW/L33ErVA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ggsgkg2KW70=:VgdU6afpn/WyxUF6a65ePA
 AnooQS6jIoyNIz6pVnNkTKiKyW90koF/6/2tbYMotbpoWuu12tU11WZgYTKVRAs/7u86IwNlK
 3d3C3o1nT9yv1MgoxdTvBXjrb6GjktbQy0nHpO6H5yy8jHsak/Ld7pCMKw6bNiBu9dL0WwQnY
 vDUtuFapBJM855TkzKUsw08u7egYM+87Iyg6eWhFO4D7UUTXq6LlI9CH5ClaQOrKSHfauw7XI
 9rg2nbGJQHLfx0QuE4uyzb8KkWBEikX+Kk2ZGB6NlBSw0HGRp5T8bYtTty9Xl7cI0LaUhdH7y
 3KF40dilZgZjnQLlAbi24JV9Bv2rH9u0b6s3S0S6SBcqxQI3IPTbmpxUooLJk1q7RnUa4d/XJ
 pPuFn/qtov6xZXUfErhKG2GdfI8ASdbPzDhMLG197WNzpBl+2mCFXxq8LQj5yJq2DLgENWpBg
 hbBcUzfiHSb7xDDLYbXf+xNUH0/nVQFGasKXZlxq4TYXkX3DoSt58A9jw23r5/15lXuBFHEll
 dSXjPgiUwzE+yy0d1icbJHj2u34D6TYsw+UW6eLrHTHMnw7OW+oQO83NrdGZgcw1nR+rZQSOq
 1tfBUenae40phnMyoO6a90a3Gr92QxeJ0IM3NBJfe858I883KfQwi9t2MRe9ApKFRJ/B7TCzw
 gjZFwyVy51NRZyZA96Q1hBA+m8Mbto5Lv+9XXs/v8QPKPAOtLNyrWHbYf36rO2A88bwUfu9Ym
 lKnHYVl75S1tsbNeFgIQoqDhnCAkhhKI8r3bE/OBjnKSoq0WYTzAaWuTYb+pwXGcWJGYev71M
 4/Z/Y74TuyNLIN1+1Uq23NN/WBFxtuXith2nBtO04NtDYLvLTEr0Q/L0h/HEWN+SsxAh8WD1S
 hVXxcSJSvj4f3mkfhY0w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2020 at 7:42 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 10-01-20, 12:15, Arnd Bergmann wrote:
> > On Fri, Jan 10, 2020 at 10:43 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > Simply dropping the __iomem isn't much better, now you get other
> > type mismatches.
>
> Right. So what exactly do you suggest I should do now? Drop __iomem
> from the structure's payload field but keep all local variables and
> function arguments with __iomem ?

> > > +struct scmi_chan_info {
> > > +       void *payload;
> > > +       struct device *dev;
> > > +       struct scmi_handle *handle;
> > > +       void *transport_info;
> > > +};
> >
> > Maybe you can wrap the scmi_chan_info inside of another
> > structure that contains  the payload pointer, and use container_of
> > to convert between them?
>
> We don't need to convert between the two of them, isn't it ? Are you
> referring some other field here ?

> > It's not obvious which parts of the structure should be shared and
> > which are transport specific.
>
> All transport specific information is kept in the transport specific
> structure which is saved here in the transport_info field. Is there
> something else that isn't clear ?

To answer all three, what I meant is that the payload pointer appears
to be transport specific and should not be part of the common
structure if there is generic way to access it.

      Arnd

Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7278EC33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 11:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4787920848
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 11:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgAJLQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 06:16:16 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:60181 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbgAJLQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 06:16:15 -0500
Received: from mail-qt1-f171.google.com ([209.85.160.171]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MNssA-1j0mLV3kue-00OCkk for <linux-kernel@vger.kernel.org>; Fri, 10 Jan
 2020 12:16:14 +0100
Received: by mail-qt1-f171.google.com with SMTP id e5so1560378qtm.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 03:16:13 -0800 (PST)
X-Gm-Message-State: APjAAAWNrdBXXKIkcLEui8EUfJTgZcs6mla5UhPAkvNI6zoabrppFJbM
        rtoXARcXTIuFWIlu8pYNChWvP7pl6pUeBpnPeYc=
X-Google-Smtp-Source: APXvYqzPSbZnYflLqoz2lIHl1CaiiXPaPPS2fouoKNm2ggHKUo+eBphF/usWgjsuuKRSk7/g/+RZJMdHGQs0hp2ZmSI=
X-Received: by 2002:ac8:6153:: with SMTP id d19mr1898412qtm.18.1578654972819;
 Fri, 10 Jan 2020 03:16:12 -0800 (PST)
MIME-Version: 1.0
References: <3f5567ec928e20963d729350e6d674c4acb0c7a0.1578648530.git.viresh.kumar@linaro.org>
In-Reply-To: <3f5567ec928e20963d729350e6d674c4acb0c7a0.1578648530.git.viresh.kumar@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 10 Jan 2020 12:15:56 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1MLyP4ooyEDiBF1fE0BJGocgDmO1f5Qrvn_W5eqahz8g@mail.gmail.com>
Message-ID: <CAK8P3a1MLyP4ooyEDiBF1fE0BJGocgDmO1f5Qrvn_W5eqahz8g@mail.gmail.com>
Subject: Re: [PATCH V2] firmware: arm_scmi: Make scmi core independent of
 transport type
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        cristian.marussi@arm.com, peng.fan@nxp.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:PmR+b4Bi+uTphgYWA18HfF+ZwQj/77XPpNFudD77F+PzYvK8dA2
 wK9EAKiVpRi0KEIMvCV63yraHbK63mlaS+3ZKx7hVDEvk39Cf3ggQl+LFhFyfe7J2P7mSSE
 ZJymy3oq+69l2XEgL9qcCdIHipqncj14jWYe48sIWgZxFyWuskfeE818eNy3mWGDnFcW/48
 1jrEwwKr5fAt79vuNvIVg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xR4nJEY9MhU=:JEU8XzkHyqkVTKxJMve+RH
 puRaQuq5Yo+0CkjXQ51R7u5g+8PMRrFkpMNXMPC37SJ8zmuBZO651QoZ1Y8ZQa7Du/8cLrrF5
 9ZtQ3iLvfvqVQzZMRBep3OZhoFwVcQlYUjiCCeqz7pzgQOM7v+YDJS0RKsjCfkbQbTahPEEKa
 KQopPKJ6RQ0nja5M9f0c0TKee4ScGk2AFPopzDVOx1U63N4w1sOsAEz9L7nVNi31hvX2DC8/B
 BMnl8i8RLxN42ifUb52yvGp/UBNP/LDASAQ6URh8CV3jsrj1XASnxIl1lVwAp1wXjJ9h+RoUy
 lmV1Bi4dSLSsdd1QZ/IQgEj+sXIUXHzvaaVO9EnDTKao0kDASJ19qiopGoY45g5gpv2ryJSq+
 qSW7RVDZS+EMluiWaNub0bp+FHFb6HeVLLV+sO0bO668PdlSPKTm7NnvJWXVSK2FrJeDTaUVC
 k39KC07QUG+8NcCyZ/umQ5m9Ayu5N1xMa9n9QWDoERj3XpL5YYKv2ib8UpnqNWy8sgTAcoq/z
 22XR4pR92jh6oP0s9dcDBPd+m8cMj3s7uOQyckYhtw8XZoyrr+3iS0gB23xeu3iYrHhxeoKsw
 2glpmpzMO7E1f+XCi37rqxL7BFG0ajm/GxsBx18Pk3pQ+FFaxoHit+tSwLxJETqz5AwKNmoyc
 MPneNgLHnl/Nj8/WehGZtMn2vrNvJ5fmx/zFF01diVBnAYI9+oU8tIGZ1x1FfTDGfuxeKvh61
 dlikiZiz62kGlHOeZLqqzek8AkS+AqDCfu/I0Y6s4lgZ8VvDEfQRUvjXTpXs+RBcrlfJFw+k/
 sL5V/FBnI/91hTAqGkoD2TY9IMFpRrhfN7Xo3vxvJU/eUqYPDrAVBc7YKSCJVnrfo/sDmIbA2
 UdWuPL7IzWLfvGveTifQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 10, 2020 at 10:43 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> The SCMI specification is fairly independent of the transport protocol,
> which can be a simple mailbox (already implemented) or anything else.
> The current Linux implementation however is very much dependent of the
> mailbox transport layer.
>
> This patch makes the SCMI core code (driver.c) independent of the
> mailbox transport layer and moves all mailbox related code to a new
> file: mailbox.c.
>
> We can now implement more transport protocols to transport SCMI
> messages, some of the transport protocols getting discussed currently
> are SMC/HVC, SPCI (built on top of SMC/HVC), OPTEE based mailbox
> (similar to SPCI), and vitio based transport as alternative to mailbox.
>
> The transport protocols just need to provide struct scmi_desc, which
> also implements the struct scmi_transport_ops.
>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V2:
> - Dropped __iomem from payload data.

Simply dropping the __iomem isn't much better, now you get other
type mismatches.

> - Moved transport ops to scmi_desc, and that has a per transport
>   instance now which is differentiated using the compatible string.
> - Converted IS_ERR_OR_NULL to IS_ERR.

These look good to me.

> + * @payload: Transmit/Receive payload area
> + * @dev: Reference to device in the SCMI hierarchy corresponding to this
> + *      channel
> + * @handle: Pointer to SCMI entity handle
> + * @transport_info: Transport layer related information
> + */
> +struct scmi_chan_info {
> +       void *payload;
> +       struct device *dev;
> +       struct scmi_handle *handle;
> +       void *transport_info;
> +};

Maybe you can wrap the scmi_chan_info inside of another
structure that contains  the payload pointer, and use container_of
to convert between them?

It's not obvious which parts of the structure should be shared and
which are transport specific.

> -static void scmi_rx_callback(struct mbox_client *cl, void *m)
> +void scmi_rx_callback(struct scmi_chan_info *cinfo, struct scmi_xfer *t)
>  {
>         u8 msg_type;
>         u32 msg_hdr;
>         u16 xfer_id;
>         struct scmi_xfer *xfer;
> -       struct scmi_chan_info *cinfo = client_to_scmi_chan_info(cl);
>         struct device *dev = cinfo->dev;
>         struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
>         struct scmi_xfers_info *minfo = &info->tx_minfo;
> -       struct scmi_shared_mem __iomem *mem = cinfo->payload;
> +       struct scmi_shared_mem *mem = cinfo->payload;
>
>         msg_hdr = ioread32(&mem->msg_header);

This is where it goes wrong: you cannot pass a kernel pointer
without __iomem into ioread32(). Building the driver with sparse
(using "make C=1") should show you this and possibly other
related conversion bugs.

       Arnd

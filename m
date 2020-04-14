Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5ADC2BA2B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 03:18:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3451320732
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 03:18:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBUMFK3f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404564AbgDNDSe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 23:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404542AbgDNDST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 23:18:19 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9769FC0A3BDC;
        Mon, 13 Apr 2020 20:18:19 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id u13so12118814wrp.3;
        Mon, 13 Apr 2020 20:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=giWSpSfOhp4srs/f1cIhyKITUR4isg3xeqTrICKONHY=;
        b=nBUMFK3fkZdy9DM1eKQcciB//NLauuaDyrFsHqf48+lN0sDj0eUPj89yOCX5iBSA9X
         mGOWGgGpgQraxPcw/xk/+Kwe7fLrBY31RI2zRDPGKp0zU22qbwSRpW6NpGX64C/Ja4yD
         USwz4F71Wfti6WjtpRt/ibRXx28nL7iFHprKDH2LeUmPnMdIZVr8CWflWrDol3dELEHL
         Mu+1L59w3YcSy1788twvWjjyQ4Nny8KwTupUrwDmkW6qf1QWo4J/0/0T8lTl7UCJ5BwD
         Ba6jSjgW+g7t5B9hg5HeuGONWpHLrCR203SxC9YyPyWyWsHr3Z872HULVu/iZyOZqEjS
         2IZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=giWSpSfOhp4srs/f1cIhyKITUR4isg3xeqTrICKONHY=;
        b=QxiSyjqSsprqxqF1WbMuU3zu+f+8JH1berN+/slb3TuoUvYsc48BNqe35OJFmxjnNq
         WchutkyU6F9Clb/otKQsjLeaRQTHEyWavw+xVaGvOXTo2hf8KlzfDiqhynL2h6XAPnVh
         l80uS1YAdLkvn9gpjg/MQtSPmzoiqYLLOVA3VnScjzNciy1qTEbAmSU9c8/vDh2atGlE
         iT0XukWoUW8sCC+13vNhw/hTMso/3H9NPIbAKvxFgsrgK+XIbd9fClXMoat80EILIcrO
         oN1JaTdTTeQ+6I8wZHcsuidN1Dad7awqfKvLQQ9x6P4D3cxepvXREnTcgi14SWWc6CD/
         TMrA==
X-Gm-Message-State: AGi0Pub4qM7C+5bPfyis7TKHM0/VkwgH5HuRGaaxmAr3v5wOUs98TqkR
        I9m0wY4jw1nU7a74UOscs7xwaqyNf66/Xt3JsXI=
X-Google-Smtp-Source: APiQypKMMDhD7xwuCEgfGLdUIfq0mNFjTiqY3bXUa+ho6L8vYto4kPMfkQjPu4KKTYj1zIIxbyg7zpZFZeAyD1/vGzA=
X-Received: by 2002:a5d:48cc:: with SMTP id p12mr22788314wrs.170.1586834298330;
 Mon, 13 Apr 2020 20:18:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190906023601.4378-1-andrew.smirnov@gmail.com>
In-Reply-To: <20190906023601.4378-1-andrew.smirnov@gmail.com>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Mon, 13 Apr 2020 20:18:07 -0700
Message-ID: <CAHQ1cqEqM5=Gm1jxEX=h02KW_-OLUn0W3R7T6o5bFW9+6ZPiOQ@mail.gmail.com>
Subject: Re: [RESEND PATCH v2] Bluetooth: Retry configure request if result is L2CAP_CONF_UNKNOWN
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Cc:     "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
        Florian Dollinger <dollinger.florian@gmx.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 5, 2019 at 7:36 PM Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>
> Due to:
>
>  * Current implementation of l2cap_config_rsp() dropping BT
>    connection if sender of configuration response replied with unknown
>    option failure (Result=0x0003/L2CAP_CONF_UNKNOWN)
>
>  * Current implementation of l2cap_build_conf_req() adding
>    L2CAP_CONF_RFC(0x04) option to initial configure request sent by
>    the Linux host.
>
> devices that do no recongninze L2CAP_CONF_RFC, such as Xbox One S
> controllers, will get stuck in endless connect -> configure ->
> disconnect loop, never connect and be generaly unusable.
>
> To avoid this problem add code to do the following:
>
>  1. Parse the body of response L2CAP_CONF_UNKNOWN and, in case of
>     unsupported option being RFC, clear L2CAP_FEAT_ERTM and
>     L2CAP_FEAT_STREAMING from connection's feature mask (in order to
>     prevent RFC option from being added going forward)
>
>  2. Retry configuration step the same way it's done for
>     L2CAP_CONF_UNACCEPT
>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> Cc: Pierre-Loup A. Griffais <pgriffais@valvesoftware.com>
> Cc: Florian Dollinger <dollinger.florian@gmx.de>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Johan Hedberg <johan.hedberg@gmail.com>
> Cc: linux-bluetooth@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>
> Changes since [v1]:
>
>    - Patch simplified to simply clear L2CAP_FEAT_ERTM |
>      L2CAP_FEAT_STREAMING from feat_mask when device flags RFC options
>      as unknown
>
> [v1] lore.kernel.org/r/20190208025828.30901-1-andrew.smirnov@gmail.com
>

Marcel, Johan, can either of you please comment on this patch? I've
sent a number of patches to linux-bluetooth in past 6 month all of
which were met with radio silence, so I am a bit worried that my
messages are being filtered out or dropped.

Thanks,
Andrey Smirnov


>  net/bluetooth/l2cap_core.c | 58 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index dfc1edb168b7..77b65870b064 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -4216,6 +4216,49 @@ static inline int l2cap_config_req(struct l2cap_conn *conn,
>         return err;
>  }
>
> +static inline int l2cap_config_rsp_unknown(struct l2cap_conn *conn,
> +                                          struct l2cap_chan *chan,
> +                                          const u8 *data,
> +                                          int len)
> +{
> +       char req[64];
> +
> +       if (!len || len > sizeof(req) -  sizeof(struct l2cap_conf_req))
> +               return -ECONNRESET;
> +
> +       while (len--) {
> +               const u8 option_type = *data++;
> +
> +               BT_DBG("chan %p, unknown option type: %u", chan,  option_type);
> +
> +               /* "...Hints shall not be included in the Response and
> +                * shall not be the sole cause for rejecting the
> +                * Request.."
> +                */
> +               if (option_type & L2CAP_CONF_HINT)
> +                       return -ECONNRESET;
> +
> +               switch (option_type) {
> +               case L2CAP_CONF_RFC:
> +                       /* Clearing the following feature should
> +                        * prevent RFC option from being added next
> +                        * connection attempt
> +                        */
> +                       conn->feat_mask &= ~(L2CAP_FEAT_ERTM |
> +                                            L2CAP_FEAT_STREAMING);
> +                       break;
> +               default:
> +                       return -ECONNRESET;
> +               }
> +       }
> +
> +       len = l2cap_build_conf_req(chan, req, sizeof(req));
> +       l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_CONF_REQ, len, req);
> +       chan->num_conf_req++;
> +
> +       return 0;
> +}
> +
>  static inline int l2cap_config_rsp(struct l2cap_conn *conn,
>                                    struct l2cap_cmd_hdr *cmd, u16 cmd_len,
>                                    u8 *data)
> @@ -4271,6 +4314,21 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn,
>                 }
>                 goto done;
>
> +       case L2CAP_CONF_UNKNOWN:
> +               if (chan->num_conf_rsp <= L2CAP_CONF_MAX_CONF_RSP) {
> +                       if (l2cap_config_rsp_unknown(conn, chan, rsp->data,
> +                                                    len) < 0) {
> +                               l2cap_send_disconn_req(chan, ECONNRESET);
> +                               goto done;
> +                       }
> +                       break;
> +               }
> +               /* Once, chan->num_conf_rsp goes above
> +                * L2CAP_CONF_MAX_CONF_RSP we want to go down all the
> +                * way to default label (just like L2CAP_CONF_UNACCEPT
> +                * below)
> +                */
> +               /* fall through */
>         case L2CAP_CONF_UNACCEPT:
>                 if (chan->num_conf_rsp <= L2CAP_CONF_MAX_CONF_RSP) {
>                         char req[64];
> --
> 2.21.0
>

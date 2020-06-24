Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129C2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 06:50:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E28D520738
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 06:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592981436;
	bh=IxM2E8XPXPciNcQANNnSv90YyCSqzQB4Xr3UhT3FIIU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=DorTnfFhtXKtJ9gRwlw0BJ4rR5zmWUAxZPWyYdLe0gFiBvj/GlH+130M20YYA+5Qt
	 wtdoRKB43G36K7/0FWpIqWVPrDdTJoW3+15Pf5sXLhCxbyhvcDjIMPdgMJPiWJz2fz
	 ON9twvmiipEaqf3ErbjGH6FI7iB/xkbTo8+/LMqc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389474AbgFXGug (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 02:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389354AbgFXGuf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 02:50:35 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC1C4C061573;
        Tue, 23 Jun 2020 23:50:34 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id d7so680323lfi.12;
        Tue, 23 Jun 2020 23:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=61dSScxI6iuAF78RADy83+D5pnqYcgk6lokCgPGWmSg=;
        b=C56J+Wdbca7X/pJ4WBs137eTEr59uhNcjRq8+5vk8TMUPcC5qLXbcCR6NkuFnvE8X5
         1RMauvmOt8FSdkXLLKhyrenX0v0r//m5Dz68C4LtyyELQaQ2A2ZQK5clX/SCJQDOREv6
         5PfO0JpQv6KhB+zpCwvUv2r5QL+hxTfEkeLjKZqw3ajHYeAvRSkKy4ktqs8P5suIq2MH
         ShtxMINMVRM8eIQk1knHThWjjAfvPL79AXy/kPd/vS0FtDMcqOfxgiIVnfZLu9eaI/5F
         u3g8kDPystYJJULoLjTzdFDzaAI3XDWR+mGdaiCntcT7Ig/X+noIucdKCOjbM1dVgfZh
         6TbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=61dSScxI6iuAF78RADy83+D5pnqYcgk6lokCgPGWmSg=;
        b=Yd6+lybZX2S0vtsSp3ayRqK24wqLVEP+uH546Yn3P84rvLvIOJ/mGpVyUmul5nojBM
         o0QtYp1cK1kiVq8l77pnB1IRnYURMrfo8vP1JqGasYFDEXeemSVAAu2yEIp91qC84MZx
         us4ms+vhzgD9JIFSS5w8NhU1Woirfa3WHdXkVEg66xpDw6cbjSwBpDZLHP7TLGKbE6/D
         UOXK4yAmVEF9/fpHJOKyBi0ZgOtSlVFrbjPhVIRxOMvtAVho1MjyLhcx09Yme2mFvuNU
         5X971O3BlFtZaZdrx8q2TTDvx6Od6gx0rDtxGqpB8MzaUHbCskpq8h8NlGHt5jnfHRcu
         dhJw==
X-Gm-Message-State: AOAM531b62xrsBDqoRPiKM+tdWuxx4KwSS2r0HHIdbHdUaqj9CoHCtKp
        o7QEtAKeUYiJtSMHqnNKfTei0g4HetA=
X-Google-Smtp-Source: ABdhPJxA3rBIk4b4X5pIPprB3CAMDSFVUKhJEy8wdLddOY1/vmRY2AP2D6UP38M03ms6HWHaqc4XHg==
X-Received: by 2002:a19:8c09:: with SMTP id o9mr6488675lfd.160.1592981433241;
        Tue, 23 Jun 2020 23:50:33 -0700 (PDT)
Received: from saruman (91-155-214-58.elisa-laajakaista.fi. [91.155.214.58])
        by smtp.gmail.com with ESMTPSA id i15sm4811522lfl.57.2020.06.23.23.50.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Jun 2020 23:50:32 -0700 (PDT)
From:   Felipe Balbi <balbi@kernel.org>
To:     Macpaul Lin <macpaul.lin@mediatek.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?utf-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Sergey Organov <sorganov@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>,
        Macpaul Lin <macpaul.lin@gmail.com>
Subject: Re: [PATCH v3] usb: gadget: u_serial: improve performance for large data
In-Reply-To: <1592372577-7986-1-git-send-email-macpaul.lin@mediatek.com>
References: <1592362007-7120-1-git-send-email-macpaul.lin@mediatek.com> <1592372577-7986-1-git-send-email-macpaul.lin@mediatek.com>
Date:   Wed, 24 Jun 2020 09:50:27 +0300
Message-ID: <87r1u5vtxo.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

Macpaul Lin <macpaul.lin@mediatek.com> writes:
> Nowadays some embedded systems use VCOM to transfer large log and data.
> Take LTE MODEM as an example, during the long debugging stage, large
> log and data were transfer through VCOM when doing field try or in
> operator's lab. Here we suggest slightly increase the transfer buffer
> in u_serial.c for performance improving.
>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
> Changes for v2:
>   - Drop previous patch for adding flag which indicates hardware capabili=
ty in
>     gadget.h and in DMA engine according to Alan's suggestion. Thanks.
>   - Replace requested buffer size "REQ_BUF_SIZE" instead of checking hard=
ware
>     capability.
>   - Refine commit messages.
> Changes for v3:
>   - Code: no change.
>     Commit: Add missing change log in v2.
>
>  drivers/usb/gadget/function/u_serial.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/=
function/u_serial.c
> index 3cfc6e2..d7912a9 100644
> --- a/drivers/usb/gadget/function/u_serial.c
> +++ b/drivers/usb/gadget/function/u_serial.c
> @@ -80,6 +80,7 @@
>  #define QUEUE_SIZE		16
>  #define WRITE_BUF_SIZE		8192		/* TX only */
>  #define GS_CONSOLE_BUF_SIZE	8192
> +#define REQ_BUF_SIZE		4096
>=20=20
>  /* console info */
>  struct gs_console {
> @@ -247,7 +248,7 @@ static int gs_start_tx(struct gs_port *port)
>  			break;
>=20=20
>  		req =3D list_entry(pool->next, struct usb_request, list);
> -		len =3D gs_send_packet(port, req->buf, in->maxpacket);
> +		len =3D gs_send_packet(port, req->buf, REQ_BUF_SIZE);
>  		if (len =3D=3D 0) {
>  			wake_up_interruptible(&port->drain_wait);
>  			break;
> @@ -514,7 +515,7 @@ static int gs_alloc_requests(struct usb_ep *ep, struc=
t list_head *head,
>  	 * be as speedy as we might otherwise be.
>  	 */
>  	for (i =3D 0; i < n; i++) {
> -		req =3D gs_alloc_req(ep, ep->maxpacket, GFP_ATOMIC);
> +		req =3D gs_alloc_req(ep, REQ_BUF_SIZE, GFP_ATOMIC);

since this can only be applied for the next merge window, it would be
much better if you work rework how requests are used here and, as I
mentioned in the other subthread, preallocate a list of requests that
get recycled. This would allow us to allocate memory without GFP_ATOMIC.

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl7y97MACgkQzL64meEa
mQbjAhAA0OOV27Nwx1Zd9bERbMUOxh2QI77f+9QskVbd7ub1hn/forW3/lSaOe66
jDYjYKWyi2HFYijFbyYrEJXv2aCWSn4M9YM9DdDicvc9Ny1pTT20YhATcVhr4jOI
9c3BUXc+TCcoSK/yTbs1Zt25PcktO/M07FpN4+nE1zr128yzpQmd8R5FMO68w7d/
sckWvXnCoYA2b1udE/dw9+12DE4ae3k/yW+KPrqIKX9FfhACfiDTPhsN6HHj2RnH
U5PvfahfRDPtAdUhDlB1FOyV6lDBH9I8v+2W3735aR37iylqZFVhkUoNuUoXhFcq
9HfwA04pGcb5hQTxNQmP55QclnKyKT1YgxDzF6d/7MAhEkBaghzsFN8QJDvQXKAp
3xiKH9PCD6VGOdqV7K5ID/t28hu68xaO1r+ulk53/unhCeY+6aBS7eod6PuXb0Ta
NRPJ31rvjRaDUFudPl0C6rsxvkAYwh61lGjVaYboKhjcWBLJfTxnpmx1f89OYsYB
+sIxhPgo89Q8MavGJ/F46hHm+d5/s8mGYR/kg4S04hyfO37mn9qWfUNNJf6bN5NG
RSInU5zelNjcv5ox2RpRgY0uSw+/S6YrHF7qivP3ozrlD/AUOQtxeXWV/BGs+8p4
PFWaCC0YtGYxCBY0oIzbRkRN9tU04zMZWB75NBF0gMhzBm84BBk=
=zs8r
-----END PGP SIGNATURE-----
--=-=-=--

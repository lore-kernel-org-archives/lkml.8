Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72C80C3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 12:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DE30246B0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 12:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VJtyvyrt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726103AbgB1MPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 07:15:51 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:38062 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgB1MPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 07:15:50 -0500
Received: by mail-qv1-f65.google.com with SMTP id g16so1215435qvz.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 04:15:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qNboYcAsWc/vXur7NwBlZaUk91h3o772XcdCmy1GVsg=;
        b=VJtyvyrtH+wk8QvZEKCGqYvfvykaksOWcSUtFrjwCFanb1TEWZkt0waNTzQ1pI3IQg
         IWA5jrxQ06g7GAd65ufbCIuPjE1WfE4/nQFszaBtGPd5f9B741fI9TnnjQWmb45SLoWt
         1bVVdNyM0D94YpPH6BGu4jm/FdDDBMxTQ0DJQSn5OvnCOQnePW2nUVkPaeAYfF3IY3DJ
         XPJTzyVnH8uznNtosMAN8/XGXFBJRl362Q9iBAu50BB6FN3QJfchLl3X/ZfNcBjnmAPL
         sKVES0nY+0m8fUxjFhsgpUOHapIwfNrmmVCZPbS5Cv7ZAPLui9QNn6ZtxHPk0616rLhF
         XnLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qNboYcAsWc/vXur7NwBlZaUk91h3o772XcdCmy1GVsg=;
        b=G6YXKt/JQrnjkAV8if08HE5sz5MMGQ3C4+Fvo8LDZ9hBGgN2OfqonlU8kDaWSOf/oA
         vsaX+xwot+N6DTIVGP5HQ0qVghBl7apAvGyW8o5iWjuvWibc+4Tad+GDD4xCAd/eiAP+
         lLKWxn3xHNBks52ZQpPSQJTaja5AD0O9z158ks/DRumZF+8rYH49qYe1g7c5KJY+M4Z+
         tcqdc3YEWvCCbNcJGSgGNoXcUkEKpcUhuHVBlrcpW2yIxVqsyRNTV4FHc3vSPAY86j+s
         E8JvJIciD6Ci/rN6RZY/IQ7c+5sha9rzoXKAI7fuHCMNVOp5CH78luXWcjL3F/hMTlHS
         yPtQ==
X-Gm-Message-State: APjAAAVBG64W0xdWI9LMZsYybtLyezD0yjikLiEsiGx+ASnxHBe8Cjwx
        BFj5YfOhNB699s4eoqf4N+SOlFDAU8s+VTnKW0lYN7jd
X-Google-Smtp-Source: APXvYqy/aa6VHHcGVnYsPR2n1bUbIyAgv9J6gpHPc+ccKbSYU5+bRmbj/ipA35axHESJ1DzeF9aBcFmKal8j7JO8ttg=
X-Received: by 2002:a0c:cd8e:: with SMTP id v14mr3467744qvm.182.1582892149171;
 Fri, 28 Feb 2020 04:15:49 -0800 (PST)
MIME-Version: 1.0
References: <20200205084842.5642-1-benjamin.gaignard@st.com>
In-Reply-To: <20200205084842.5642-1-benjamin.gaignard@st.com>
From:   Benjamin Gaignard <benjamin.gaignard@linaro.org>
Date:   Fri, 28 Feb 2020 13:15:38 +0100
Message-ID: <CA+M3ks66+z5+BCvWXJoM8Qs2qjkctOpCK6weop2BB0G6F7Hi7w@mail.gmail.com>
Subject: Re: [PATCH v6] drm/dp_mst: Fix W=1 warnings
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mer. 5 f=C3=A9vr. 2020 =C3=A0 09:53, Benjamin Gaignard
<benjamin.gaignard@st.com> a =C3=A9crit :
>
> Fix the warnings that show up with W=3D1.
> They are all about unused but set variables.
> If functions returns are not used anymore make them void.
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> Reviewed-by: Lyude Paul <lyude@redhat.com>

Applied on drm-misc-next

> ---
> version 6:
> - change drm_dp_check_mstb_guid() prototype to be able to return an error
> - add check for drm_dp_check_mstb_guid() return value
> - check drm_dp_dpcd_read() return value in drm_dp_mst_dump_topology()
>
> version 5:
> - fix indentation
>
> version 4:
> - do not touch crc4 unused variable in this patch
> CC: lyude@redhat.com
> CC: airlied@linux.ie
> CC: jani.nikula@linux.intel.com
>
>  drivers/gpu/drm/drm_dp_mst_topology.c | 114 +++++++++++++++++++---------=
------
>  1 file changed, 65 insertions(+), 49 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_=
dp_mst_topology.c
> index 4104f15f4594..0ced7a204985 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -1034,7 +1034,8 @@ static bool drm_dp_sideband_parse_req(struct drm_dp=
_sideband_msg_rx *raw,
>         }
>  }
>
> -static int build_dpcd_write(struct drm_dp_sideband_msg_tx *msg, u8 port_=
num, u32 offset, u8 num_bytes, u8 *bytes)
> +static void build_dpcd_write(struct drm_dp_sideband_msg_tx *msg,
> +                            u8 port_num, u32 offset, u8 num_bytes, u8 *b=
ytes)
>  {
>         struct drm_dp_sideband_msg_req_body req;
>
> @@ -1044,17 +1045,14 @@ static int build_dpcd_write(struct drm_dp_sideban=
d_msg_tx *msg, u8 port_num, u32
>         req.u.dpcd_write.num_bytes =3D num_bytes;
>         req.u.dpcd_write.bytes =3D bytes;
>         drm_dp_encode_sideband_req(&req, msg);
> -
> -       return 0;
>  }
>
> -static int build_link_address(struct drm_dp_sideband_msg_tx *msg)
> +static void build_link_address(struct drm_dp_sideband_msg_tx *msg)
>  {
>         struct drm_dp_sideband_msg_req_body req;
>
>         req.req_type =3D DP_LINK_ADDRESS;
>         drm_dp_encode_sideband_req(&req, msg);
> -       return 0;
>  }
>
>  static int build_clear_payload_id_table(struct drm_dp_sideband_msg_tx *m=
sg)
> @@ -1066,7 +1064,8 @@ static int build_clear_payload_id_table(struct drm_=
dp_sideband_msg_tx *msg)
>         return 0;
>  }
>
> -static int build_enum_path_resources(struct drm_dp_sideband_msg_tx *msg,=
 int port_num)
> +static int build_enum_path_resources(struct drm_dp_sideband_msg_tx *msg,
> +                                    int port_num)
>  {
>         struct drm_dp_sideband_msg_req_body req;
>
> @@ -1077,10 +1076,11 @@ static int build_enum_path_resources(struct drm_d=
p_sideband_msg_tx *msg, int por
>         return 0;
>  }
>
> -static int build_allocate_payload(struct drm_dp_sideband_msg_tx *msg, in=
t port_num,
> -                                 u8 vcpi, uint16_t pbn,
> -                                 u8 number_sdp_streams,
> -                                 u8 *sdp_stream_sink)
> +static void build_allocate_payload(struct drm_dp_sideband_msg_tx *msg,
> +                                  int port_num,
> +                                  u8 vcpi, uint16_t pbn,
> +                                  u8 number_sdp_streams,
> +                                  u8 *sdp_stream_sink)
>  {
>         struct drm_dp_sideband_msg_req_body req;
>         memset(&req, 0, sizeof(req));
> @@ -1093,11 +1093,10 @@ static int build_allocate_payload(struct drm_dp_s=
ideband_msg_tx *msg, int port_n
>                    number_sdp_streams);
>         drm_dp_encode_sideband_req(&req, msg);
>         msg->path_msg =3D true;
> -       return 0;
>  }
>
> -static int build_power_updown_phy(struct drm_dp_sideband_msg_tx *msg,
> -                                 int port_num, bool power_up)
> +static void build_power_updown_phy(struct drm_dp_sideband_msg_tx *msg,
> +                                  int port_num, bool power_up)
>  {
>         struct drm_dp_sideband_msg_req_body req;
>
> @@ -1109,7 +1108,6 @@ static int build_power_updown_phy(struct drm_dp_sid=
eband_msg_tx *msg,
>         req.u.port_num.port_number =3D port_num;
>         drm_dp_encode_sideband_req(&req, msg);
>         msg->path_msg =3D true;
> -       return 0;
>  }
>
>  static int drm_dp_mst_assign_payload_id(struct drm_dp_mst_topology_mgr *=
mgr,
> @@ -2052,29 +2050,24 @@ ssize_t drm_dp_mst_dpcd_write(struct drm_dp_aux *=
aux,
>                                       offset, size, buffer);
>  }
>
> -static void drm_dp_check_mstb_guid(struct drm_dp_mst_branch *mstb, u8 *g=
uid)
> +static int drm_dp_check_mstb_guid(struct drm_dp_mst_branch *mstb, u8 *gu=
id)
>  {
> -       int ret;
> +       int ret =3D 0;
>
>         memcpy(mstb->guid, guid, 16);
>
>         if (!drm_dp_validate_guid(mstb->mgr, mstb->guid)) {
>                 if (mstb->port_parent) {
> -                       ret =3D drm_dp_send_dpcd_write(
> -                                       mstb->mgr,
> -                                       mstb->port_parent,
> -                                       DP_GUID,
> -                                       16,
> -                                       mstb->guid);
> +                       ret =3D drm_dp_send_dpcd_write(mstb->mgr,
> +                                                    mstb->port_parent,
> +                                                    DP_GUID, 16, mstb->g=
uid);
>                 } else {
> -
> -                       ret =3D drm_dp_dpcd_write(
> -                                       mstb->mgr->aux,
> -                                       DP_GUID,
> -                                       mstb->guid,
> -                                       16);
> +                       ret =3D drm_dp_dpcd_write(mstb->mgr->aux,
> +                                               DP_GUID, mstb->guid, 16);
>                 }
>         }
> +
> +       return ret;
>  }
>
>  static void build_mst_prop_path(const struct drm_dp_mst_branch *mstb,
> @@ -2595,7 +2588,8 @@ static bool drm_dp_validate_guid(struct drm_dp_mst_=
topology_mgr *mgr,
>         return false;
>  }
>
> -static int build_dpcd_read(struct drm_dp_sideband_msg_tx *msg, u8 port_n=
um, u32 offset, u8 num_bytes)
> +static void build_dpcd_read(struct drm_dp_sideband_msg_tx *msg,
> +                           u8 port_num, u32 offset, u8 num_bytes)
>  {
>         struct drm_dp_sideband_msg_req_body req;
>
> @@ -2604,8 +2598,6 @@ static int build_dpcd_read(struct drm_dp_sideband_m=
sg_tx *msg, u8 port_num, u32
>         req.u.dpcd_read.dpcd_address =3D offset;
>         req.u.dpcd_read.num_bytes =3D num_bytes;
>         drm_dp_encode_sideband_req(&req, msg);
> -
> -       return 0;
>  }
>
>  static int drm_dp_send_sideband_msg(struct drm_dp_mst_topology_mgr *mgr,
> @@ -2828,7 +2820,7 @@ static int drm_dp_send_link_address(struct drm_dp_m=
st_topology_mgr *mgr,
>         struct drm_dp_sideband_msg_tx *txmsg;
>         struct drm_dp_link_address_ack_reply *reply;
>         struct drm_dp_mst_port *port, *tmp;
> -       int i, len, ret, port_mask =3D 0;
> +       int i, ret, port_mask =3D 0;
>         bool changed =3D false;
>
>         txmsg =3D kzalloc(sizeof(*txmsg), GFP_KERNEL);
> @@ -2836,7 +2828,7 @@ static int drm_dp_send_link_address(struct drm_dp_m=
st_topology_mgr *mgr,
>                 return -ENOMEM;
>
>         txmsg->dst =3D mstb;
> -       len =3D build_link_address(txmsg);
> +       build_link_address(txmsg);
>
>         mstb->link_address_sent =3D true;
>         drm_dp_queue_down_tx(mgr, txmsg);
> @@ -2857,7 +2849,9 @@ static int drm_dp_send_link_address(struct drm_dp_m=
st_topology_mgr *mgr,
>         DRM_DEBUG_KMS("link address reply: %d\n", reply->nports);
>         drm_dp_dump_link_address(reply);
>
> -       drm_dp_check_mstb_guid(mstb, reply->guid);
> +       ret =3D drm_dp_check_mstb_guid(mstb, reply->guid);
> +       if (ret)
> +               goto out;
>
>         for (i =3D 0; i < reply->nports; i++) {
>                 port_mask |=3D BIT(reply->ports[i].port_number);
> @@ -2898,14 +2892,14 @@ void drm_dp_send_clear_payload_id_table(struct dr=
m_dp_mst_topology_mgr *mgr,
>                                         struct drm_dp_mst_branch *mstb)
>  {
>         struct drm_dp_sideband_msg_tx *txmsg;
> -       int len, ret;
> +       int ret;
>
>         txmsg =3D kzalloc(sizeof(*txmsg), GFP_KERNEL);
>         if (!txmsg)
>                 return;
>
>         txmsg->dst =3D mstb;
> -       len =3D build_clear_payload_id_table(txmsg);
> +       build_clear_payload_id_table(txmsg);
>
>         drm_dp_queue_down_tx(mgr, txmsg);
>
> @@ -2923,7 +2917,6 @@ drm_dp_send_enum_path_resources(struct drm_dp_mst_t=
opology_mgr *mgr,
>  {
>         struct drm_dp_enum_path_resources_ack_reply *path_res;
>         struct drm_dp_sideband_msg_tx *txmsg;
> -       int len;
>         int ret;
>
>         txmsg =3D kzalloc(sizeof(*txmsg), GFP_KERNEL);
> @@ -2931,7 +2924,7 @@ drm_dp_send_enum_path_resources(struct drm_dp_mst_t=
opology_mgr *mgr,
>                 return -ENOMEM;
>
>         txmsg->dst =3D mstb;
> -       len =3D build_enum_path_resources(txmsg, port->port_num);
> +       build_enum_path_resources(txmsg, port->port_num);
>
>         drm_dp_queue_down_tx(mgr, txmsg);
>
> @@ -3014,7 +3007,7 @@ static int drm_dp_payload_send_msg(struct drm_dp_ms=
t_topology_mgr *mgr,
>  {
>         struct drm_dp_sideband_msg_tx *txmsg;
>         struct drm_dp_mst_branch *mstb;
> -       int len, ret, port_num;
> +       int ret, port_num;
>         u8 sinks[DRM_DP_MAX_SDP_STREAMS];
>         int i;
>
> @@ -3039,9 +3032,9 @@ static int drm_dp_payload_send_msg(struct drm_dp_ms=
t_topology_mgr *mgr,
>                 sinks[i] =3D i;
>
>         txmsg->dst =3D mstb;
> -       len =3D build_allocate_payload(txmsg, port_num,
> -                                    id,
> -                                    pbn, port->num_sdp_streams, sinks);
> +       build_allocate_payload(txmsg, port_num,
> +                              id,
> +                              pbn, port->num_sdp_streams, sinks);
>
>         drm_dp_queue_down_tx(mgr, txmsg);
>
> @@ -3070,7 +3063,7 @@ int drm_dp_send_power_updown_phy(struct drm_dp_mst_=
topology_mgr *mgr,
>                                  struct drm_dp_mst_port *port, bool power=
_up)
>  {
>         struct drm_dp_sideband_msg_tx *txmsg;
> -       int len, ret;
> +       int ret;
>
>         port =3D drm_dp_mst_topology_get_port_validated(mgr, port);
>         if (!port)
> @@ -3083,7 +3076,7 @@ int drm_dp_send_power_updown_phy(struct drm_dp_mst_=
topology_mgr *mgr,
>         }
>
>         txmsg->dst =3D port->parent;
> -       len =3D build_power_updown_phy(txmsg, port->port_num, power_up);
> +       build_power_updown_phy(txmsg, port->port_num, power_up);
>         drm_dp_queue_down_tx(mgr, txmsg);
>
>         ret =3D drm_dp_mst_wait_tx_reply(port->parent, txmsg);
> @@ -3305,7 +3298,6 @@ static int drm_dp_send_dpcd_read(struct drm_dp_mst_=
topology_mgr *mgr,
>                                  struct drm_dp_mst_port *port,
>                                  int offset, int size, u8 *bytes)
>  {
> -       int len;
>         int ret =3D 0;
>         struct drm_dp_sideband_msg_tx *txmsg;
>         struct drm_dp_mst_branch *mstb;
> @@ -3320,7 +3312,7 @@ static int drm_dp_send_dpcd_read(struct drm_dp_mst_=
topology_mgr *mgr,
>                 goto fail_put;
>         }
>
> -       len =3D build_dpcd_read(txmsg, port->port_num, offset, size);
> +       build_dpcd_read(txmsg, port->port_num, offset, size);
>         txmsg->dst =3D port->parent;
>
>         drm_dp_queue_down_tx(mgr, txmsg);
> @@ -3358,7 +3350,6 @@ static int drm_dp_send_dpcd_write(struct drm_dp_mst=
_topology_mgr *mgr,
>                                   struct drm_dp_mst_port *port,
>                                   int offset, int size, u8 *bytes)
>  {
> -       int len;
>         int ret;
>         struct drm_dp_sideband_msg_tx *txmsg;
>         struct drm_dp_mst_branch *mstb;
> @@ -3373,7 +3364,7 @@ static int drm_dp_send_dpcd_write(struct drm_dp_mst=
_topology_mgr *mgr,
>                 goto fail_put;
>         }
>
> -       len =3D build_dpcd_write(txmsg, port->port_num, offset, size, byt=
es);
> +       build_dpcd_write(txmsg, port->port_num, offset, size, bytes);
>         txmsg->dst =3D mstb;
>
>         drm_dp_queue_down_tx(mgr, txmsg);
> @@ -3619,7 +3610,12 @@ int drm_dp_mst_topology_mgr_resume(struct drm_dp_m=
st_topology_mgr *mgr,
>                 DRM_DEBUG_KMS("dpcd read failed - undocked during suspend=
?\n");
>                 goto out_fail;
>         }
> -       drm_dp_check_mstb_guid(mgr->mst_primary, guid);
> +
> +       ret =3D drm_dp_check_mstb_guid(mgr->mst_primary, guid);
> +       if (ret) {
> +               DRM_DEBUG_KMS("check mstb failed - undocked during suspen=
d?\n");
> +               goto out_fail;
> +       }
>
>         /*
>          * For the final step of resuming the topology, we need to bring =
the
> @@ -4532,15 +4528,34 @@ void drm_dp_mst_dump_topology(struct seq_file *m,
>                 int ret;
>
>                 ret =3D drm_dp_dpcd_read(mgr->aux, DP_DPCD_REV, buf, DP_R=
ECEIVER_CAP_SIZE);
> +               if (ret) {
> +                       seq_printf(m, "dpcd read failed\n");
> +                       goto out;
> +               }
>                 seq_printf(m, "dpcd: %*ph\n", DP_RECEIVER_CAP_SIZE, buf);
> +
>                 ret =3D drm_dp_dpcd_read(mgr->aux, DP_FAUX_CAP, buf, 2);
> +               if (ret) {
> +                       seq_printf(m, "faux/mst read failed\n");
> +                       goto out;
> +               }
>                 seq_printf(m, "faux/mst: %*ph\n", 2, buf);
> +
>                 ret =3D drm_dp_dpcd_read(mgr->aux, DP_MSTM_CTRL, buf, 1);
> +               if (ret) {
> +                       seq_printf(m, "mst ctrl read failed\n");
> +                       goto out;
> +               }
>                 seq_printf(m, "mst ctrl: %*ph\n", 1, buf);
>
>                 /* dump the standard OUI branch header */
>                 ret =3D drm_dp_dpcd_read(mgr->aux, DP_BRANCH_OUI, buf, DP=
_BRANCH_OUI_HEADER_SIZE);
> +               if (ret) {
> +                       seq_printf(m, "branch oui read failed\n");
> +                       goto out;
> +               }
>                 seq_printf(m, "branch oui: %*phN devid: ", 3, buf);
> +
>                 for (i =3D 0x3; i < 0x8 && buf[i]; i++)
>                         seq_printf(m, "%c", buf[i]);
>                 seq_printf(m, " revision: hw: %x.%x sw: %x.%x\n",
> @@ -4549,6 +4564,7 @@ void drm_dp_mst_dump_topology(struct seq_file *m,
>                         seq_printf(m, "payload table: %*ph\n", DP_PAYLOAD=
_TABLE_SIZE, buf);
>         }
>
> +out:
>         mutex_unlock(&mgr->lock);
>
>  }
> --
> 2.15.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

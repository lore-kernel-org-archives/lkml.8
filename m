Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B34BC2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 22:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC9D72071A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 22:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P2HPHnmY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgAXWIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 17:08:20 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:27784 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725821AbgAXWIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 17:08:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579903696;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2TNGppD2oDpJ0k8erqfBJy309kbxsvAM/aJTy/b+5LI=;
        b=P2HPHnmY5kyn3+cFqdoNsFNlRLiSufVj4D8vsWmrmmlqoHFpemj+GNSHLng1H9y9DtY+kM
        YEOya5YCqfXvxEfsA5on5oGGz5I9ZJNz1XEdub5jpMwzm6vGgNd0T+Q9N5MFzljZV30Svc
        IwpxwKWHzgGyDHhCGkc/JJhH3MlTk8Y=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-VlUhOYflOuWmaAWx-toLxg-1; Fri, 24 Jan 2020 17:08:15 -0500
X-MC-Unique: VlUhOYflOuWmaAWx-toLxg-1
Received: by mail-qk1-f198.google.com with SMTP id y6so2031085qki.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 14:08:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=2TNGppD2oDpJ0k8erqfBJy309kbxsvAM/aJTy/b+5LI=;
        b=RiKJDMKAnygzg5S9XISpQ3+7nrwDlKQOtFEESX0I2whJXNUQE9i/LAdW3vKaxzwveY
         mBQD7bXlpDZMBGnQJ+PYNyag51DLAg2iliUPSqbOc7MzKpXkDc272rwCgXrVzACkkA9R
         NdfOv1+CPfxRd82s+Oz3KdbnMqSE8oafr4tblQ8Ww973+G5Lg+2IigJgqyTehOjAaQQ3
         Hn9kUHF/pH6wrcntkVKbzEKE0DREkopDONyjSxaOAWCh1c+YUA6toNOAE8p1KWYN0sc5
         TDNtBDr8tNzvX5vOB3Swn/y5Go04biBdfy+oYDgGV7wfuPFdS0LD6+pLNiiI/xlV6Gji
         G7aQ==
X-Gm-Message-State: APjAAAXQazkcfqOd/+wRl21cEmwFybQPJ29Rhni5zUCM4298QcbgH85N
        YJSx0rh/MjMZNMMs6G9wdWGjyvPMy18Ntb0X6JG5mUBsZ7C4ShMZglxXTuP4/UD4S4yeE8cwIn6
        Imnc3YjYRQbWDNONvEQBJVF0W
X-Received: by 2002:a37:b05:: with SMTP id 5mr5180654qkl.429.1579903694338;
        Fri, 24 Jan 2020 14:08:14 -0800 (PST)
X-Google-Smtp-Source: APXvYqxu62r+m3D/BkuUclwkE+nCxFM3C8EBebE/gYkf2K02Z5NcKQuGFg4/x0nm27PqfKAAKp00Zg==
X-Received: by 2002:a37:b05:: with SMTP id 5mr5180624qkl.429.1579903693912;
        Fri, 24 Jan 2020 14:08:13 -0800 (PST)
Received: from dhcp-10-20-1-90.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id k22sm4101892qkg.80.2020.01.24.14.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 14:08:13 -0800 (PST)
Message-ID: <b273036b10d8c2882800d01dcda7392e93b731fa.camel@redhat.com>
Subject: Re: [PATCH v3] drm/dp_mst: Fix W=1 warnings
From:   Lyude Paul <lyude@redhat.com>
To:     Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Date:   Fri, 24 Jan 2020 17:08:12 -0500
In-Reply-To: <CA+M3ks4yEBejzMoXPw_OK_LNP7ag5SNXZjvHqNeuZ8+9r2X-qw@mail.gmail.com>
References: <20191128135057.20020-1-benjamin.gaignard@st.com>
         <878snsvxzu.fsf@intel.com>
         <CA+M3ks5WvYoDLSrbvaGBbJg9+nnkX=xyCiD389QD8tSCdNqB+g@mail.gmail.com>
         <CA+M3ks4Y4LemFh=dQds91Z-LGJPK3vHKv=GeUNYHjNhdwz_m2g@mail.gmail.com>
         <CA+M3ks4yEBejzMoXPw_OK_LNP7ag5SNXZjvHqNeuZ8+9r2X-qw@mail.gmail.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-01-07 at 14:11 +0100, Benjamin Gaignard wrote:
> Le ven. 20 déc. 2019 à 15:03, Benjamin Gaignard
> <benjamin.gaignard@linaro.org> a écrit :
> > Le lun. 16 déc. 2019 à 09:28, Benjamin Gaignard
> > <benjamin.gaignard@linaro.org> a écrit :
> > > Le mer. 4 déc. 2019 à 17:47, Jani Nikula <jani.nikula@linux.intel.com> a
> > > écrit :
> > > > On Thu, 28 Nov 2019, Benjamin Gaignard <benjamin.gaignard@st.com>
> > > > wrote:
> > > > > Fix the warnings that show up with W=1.
> > > > > They are all about unused but set variables.
> > > > > If functions returns are not used anymore make them void.
> > > > > 
> > > > > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> > > > > ---
> > > > > CC: Jani Nikula <jani.nikula@linux.intel.com>
> > > > > 
> > > > > changes in version 3:
> > > > > - remove the hunk that may conflict with c485e2c97dae
> > > > >   ("drm/dp_mst: Refactor pdt setup/teardown, add more locking")
> > > > > 
> > > > > changes in version 2:
> > > > > - fix indentations
> > > > > - when possible change functions prototype to void
> > > > > 
> > > > > drivers/gpu/drm/drm_dp_mst_topology.c | 83 +++++++++++++----------
> > > > > ------------
> > > > >  1 file changed, 31 insertions(+), 52 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> > > > > b/drivers/gpu/drm/drm_dp_mst_topology.c
> > > > > index 1437bc46368b..d5cb5688b5dd 100644
> > > > > --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> > > > > +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> > > > > @@ -674,7 +674,6 @@ static bool drm_dp_sideband_msg_build(struct
> > > > > drm_dp_sideband_msg_rx *msg,
> > > > >                                     u8 *replybuf, u8 replybuflen,
> > > > > bool hdr)
> > > > >  {
> > > > >       int ret;
> > > > > -     u8 crc4;
> > > > > 
> > > > >       if (hdr) {
> > > > >               u8 hdrlen;
> > > > > @@ -716,8 +715,6 @@ static bool drm_dp_sideband_msg_build(struct
> > > > > drm_dp_sideband_msg_rx *msg,
> > > > >       }
> > > > > 
> > > > >       if (msg->curchunk_idx >= msg->curchunk_len) {
> > > > > -             /* do CRC */
> > > > > -             crc4 = drm_dp_msg_data_crc4(msg->chunk, msg-
> > > > > >curchunk_len - 1);
> > > > 
> > > > Again, someone needs to check if crc4 should be *used* instead of
> > > > thrown
> > > > away. Blindly throwing stuff out is not the way to go.
> > > 
> > > Hi Dave,
> > > 
> > 
> > + Lyude who has been hacking in this code recently
> 
> gentle ping for the reviewers,
> 
hi-actually yes, we should probably be using this instead of just dropping
this. Also, I didn't write this code originally I just refactored a bunch of
it - Dave Airlied is the original author, but the original version of this
code was written ages ago. tbh, I think it's a safe bet to say that they
probably did mean to use this but forgot to and no one noticed until now.

> Thanks,
> Benjamin
> > > Your are the original writer of this code, could you tell us if we can
> > > drop crc4
> > > ao if there is something else that I have misunderstood ?
> > > 
> > > Thanks,
> > > Benjamin
> > > 
> > > > BR,
> > > > Jani.
> > > > 
> > > > >               /* copy chunk into bigger msg */
> > > > >               memcpy(&msg->msg[msg->curlen], msg->chunk, msg-
> > > > > >curchunk_len - 1);
> > > > >               msg->curlen += msg->curchunk_len - 1;
> > > > > @@ -1014,7 +1011,7 @@ static bool drm_dp_sideband_parse_req(struct
> > > > > drm_dp_sideband_msg_rx *raw,
> > > > >       }
> > > > >  }
> > > > > 
> > > > > -static int build_dpcd_write(struct drm_dp_sideband_msg_tx *msg, u8
> > > > > port_num, u32 offset, u8 num_bytes, u8 *bytes)
> > > > > +static void build_dpcd_write(struct drm_dp_sideband_msg_tx *msg, u8
> > > > > port_num, u32 offset, u8 num_bytes, u8 *bytes)
> > > > >  {
> > > > >       struct drm_dp_sideband_msg_req_body req;
> > > > > 
> > > > > @@ -1024,17 +1021,14 @@ static int build_dpcd_write(struct
> > > > > drm_dp_sideband_msg_tx *msg, u8 port_num, u32
> > > > >       req.u.dpcd_write.num_bytes = num_bytes;
> > > > >       req.u.dpcd_write.bytes = bytes;
> > > > >       drm_dp_encode_sideband_req(&req, msg);
> > > > > -
> > > > > -     return 0;
> > > > >  }
> > > > > 
> > > > > -static int build_link_address(struct drm_dp_sideband_msg_tx *msg)
> > > > > +static void build_link_address(struct drm_dp_sideband_msg_tx *msg)
> > > > >  {
> > > > >       struct drm_dp_sideband_msg_req_body req;
> > > > > 
> > > > >       req.req_type = DP_LINK_ADDRESS;
> > > > >       drm_dp_encode_sideband_req(&req, msg);
> > > > > -     return 0;
> > > > >  }
> > > > > 
> > > > >  static int build_enum_path_resources(struct drm_dp_sideband_msg_tx
> > > > > *msg, int port_num)
> > > > > @@ -1048,7 +1042,7 @@ static int build_enum_path_resources(struct
> > > > > drm_dp_sideband_msg_tx *msg, int por
> > > > >       return 0;
> > > > >  }
> > > > > 
> > > > > -static int build_allocate_payload(struct drm_dp_sideband_msg_tx
> > > > > *msg, int port_num,
> > > > > +static void build_allocate_payload(struct drm_dp_sideband_msg_tx
> > > > > *msg, int port_num,
> > > > >                                 u8 vcpi, uint16_t pbn,
> > > > >                                 u8 number_sdp_streams,
> > > > >                                 u8 *sdp_stream_sink)
> > > > > @@ -1064,10 +1058,9 @@ static int build_allocate_payload(struct
> > > > > drm_dp_sideband_msg_tx *msg, int port_n
> > > > >                  number_sdp_streams);
> > > > >       drm_dp_encode_sideband_req(&req, msg);
> > > > >       msg->path_msg = true;
> > > > > -     return 0;
> > > > >  }
> > > > > 
> > > > > -static int build_power_updown_phy(struct drm_dp_sideband_msg_tx
> > > > > *msg,
> > > > > +static void build_power_updown_phy(struct drm_dp_sideband_msg_tx
> > > > > *msg,
> > > > >                                 int port_num, bool power_up)
> > > > >  {
> > > > >       struct drm_dp_sideband_msg_req_body req;
> > > > > @@ -1080,7 +1073,6 @@ static int build_power_updown_phy(struct
> > > > > drm_dp_sideband_msg_tx *msg,
> > > > >       req.u.port_num.port_number = port_num;
> > > > >       drm_dp_encode_sideband_req(&req, msg);
> > > > >       msg->path_msg = true;
> > > > > -     return 0;
> > > > >  }
> > > > > 
> > > > >  static int drm_dp_mst_assign_payload_id(struct
> > > > > drm_dp_mst_topology_mgr *mgr,
> > > > > @@ -1746,14 +1738,13 @@ static u8 drm_dp_calculate_rad(struct
> > > > > drm_dp_mst_port *port,
> > > > >   */
> > > > >  static bool drm_dp_port_setup_pdt(struct drm_dp_mst_port *port)
> > > > >  {
> > > > > -     int ret;
> > > > >       u8 rad[6], lct;
> > > > >       bool send_link = false;
> > > > >       switch (port->pdt) {
> > > > >       case DP_PEER_DEVICE_DP_LEGACY_CONV:
> > > > >       case DP_PEER_DEVICE_SST_SINK:
> > > > >               /* add i2c over sideband */
> > > > > -             ret = drm_dp_mst_register_i2c_bus(&port->aux);
> > > > > +             drm_dp_mst_register_i2c_bus(&port->aux);
> > > > >               break;
> > > > >       case DP_PEER_DEVICE_MST_BRANCHING:
> > > > >               lct = drm_dp_calculate_rad(port, rad);
> > > > > @@ -1823,25 +1814,20 @@ ssize_t drm_dp_mst_dpcd_write(struct
> > > > > drm_dp_aux *aux,
> > > > > 
> > > > >  static void drm_dp_check_mstb_guid(struct drm_dp_mst_branch *mstb,
> > > > > u8 *guid)
> > > > >  {
> > > > > -     int ret;
> > > > > -
> > > > >       memcpy(mstb->guid, guid, 16);
> > > > > 
> > > > >       if (!drm_dp_validate_guid(mstb->mgr, mstb->guid)) {
> > > > >               if (mstb->port_parent) {
> > > > > -                     ret = drm_dp_send_dpcd_write(
> > > > > -                                     mstb->mgr,
> > > > > -                                     mstb->port_parent,
> > > > > -                                     DP_GUID,
> > > > > -                                     16,
> > > > > -                                     mstb->guid);
> > > > > +                     drm_dp_send_dpcd_write(mstb->mgr,
> > > > > +                                            mstb->port_parent,
> > > > > +                                            DP_GUID,
> > > > > +                                            16,
> > > > > +                                            mstb->guid);
> > > > >               } else {
> > > > > -
> > > > > -                     ret = drm_dp_dpcd_write(
> > > > > -                                     mstb->mgr->aux,
> > > > > -                                     DP_GUID,
> > > > > -                                     mstb->guid,
> > > > > -                                     16);
> > > > > +                     drm_dp_dpcd_write(mstb->mgr->aux,
> > > > > +                                       DP_GUID,
> > > > > +                                       mstb->guid,
> > > > > +                                       16);
> > > > >               }
> > > > >       }
> > > > >  }
> > > > > @@ -2197,7 +2183,7 @@ static bool drm_dp_validate_guid(struct
> > > > > drm_dp_mst_topology_mgr *mgr,
> > > > >       return false;
> > > > >  }
> > > > > 
> > > > > -static int build_dpcd_read(struct drm_dp_sideband_msg_tx *msg, u8
> > > > > port_num, u32 offset, u8 num_bytes)
> > > > > +static void build_dpcd_read(struct drm_dp_sideband_msg_tx *msg, u8
> > > > > port_num, u32 offset, u8 num_bytes)
> > > > >  {
> > > > >       struct drm_dp_sideband_msg_req_body req;
> > > > > 
> > > > > @@ -2206,8 +2192,6 @@ static int build_dpcd_read(struct
> > > > > drm_dp_sideband_msg_tx *msg, u8 port_num, u32
> > > > >       req.u.dpcd_read.dpcd_address = offset;
> > > > >       req.u.dpcd_read.num_bytes = num_bytes;
> > > > >       drm_dp_encode_sideband_req(&req, msg);
> > > > > -
> > > > > -     return 0;
> > > > >  }
> > > > > 
> > > > >  static int drm_dp_send_sideband_msg(struct drm_dp_mst_topology_mgr
> > > > > *mgr,
> > > > > @@ -2429,14 +2413,14 @@ static void drm_dp_send_link_address(struct
> > > > > drm_dp_mst_topology_mgr *mgr,
> > > > >  {
> > > > >       struct drm_dp_sideband_msg_tx *txmsg;
> > > > >       struct drm_dp_link_address_ack_reply *reply;
> > > > > -     int i, len, ret;
> > > > > +     int i, ret;
> > > > > 
> > > > >       txmsg = kzalloc(sizeof(*txmsg), GFP_KERNEL);
> > > > >       if (!txmsg)
> > > > >               return;
> > > > > 
> > > > >       txmsg->dst = mstb;
> > > > > -     len = build_link_address(txmsg);
> > > > > +     build_link_address(txmsg);
> > > > > 
> > > > >       mstb->link_address_sent = true;
> > > > >       drm_dp_queue_down_tx(mgr, txmsg);
> > > > > @@ -2478,7 +2462,6 @@ drm_dp_send_enum_path_resources(struct
> > > > > drm_dp_mst_topology_mgr *mgr,
> > > > >  {
> > > > >       struct drm_dp_enum_path_resources_ack_reply *path_res;
> > > > >       struct drm_dp_sideband_msg_tx *txmsg;
> > > > > -     int len;
> > > > >       int ret;
> > > > > 
> > > > >       txmsg = kzalloc(sizeof(*txmsg), GFP_KERNEL);
> > > > > @@ -2486,7 +2469,7 @@ drm_dp_send_enum_path_resources(struct
> > > > > drm_dp_mst_topology_mgr *mgr,
> > > > >               return -ENOMEM;
> > > > > 
> > > > >       txmsg->dst = mstb;
> > > > > -     len = build_enum_path_resources(txmsg, port->port_num);
> > > > > +     build_enum_path_resources(txmsg, port->port_num);
> > > > > 
> > > > >       drm_dp_queue_down_tx(mgr, txmsg);
> > > > > 
> > > > > @@ -2569,7 +2552,7 @@ static int drm_dp_payload_send_msg(struct
> > > > > drm_dp_mst_topology_mgr *mgr,
> > > > >  {
> > > > >       struct drm_dp_sideband_msg_tx *txmsg;
> > > > >       struct drm_dp_mst_branch *mstb;
> > > > > -     int len, ret, port_num;
> > > > > +     int ret, port_num;
> > > > >       u8 sinks[DRM_DP_MAX_SDP_STREAMS];
> > > > >       int i;
> > > > > 
> > > > > @@ -2594,9 +2577,9 @@ static int drm_dp_payload_send_msg(struct
> > > > > drm_dp_mst_topology_mgr *mgr,
> > > > >               sinks[i] = i;
> > > > > 
> > > > >       txmsg->dst = mstb;
> > > > > -     len = build_allocate_payload(txmsg, port_num,
> > > > > -                                  id,
> > > > > -                                  pbn, port->num_sdp_streams,
> > > > > sinks);
> > > > > +     build_allocate_payload(txmsg, port_num,
> > > > > +                            id,
> > > > > +                            pbn, port->num_sdp_streams, sinks);
> > > > > 
> > > > >       drm_dp_queue_down_tx(mgr, txmsg);
> > > > > 
> > > > > @@ -2625,7 +2608,7 @@ int drm_dp_send_power_updown_phy(struct
> > > > > drm_dp_mst_topology_mgr *mgr,
> > > > >                                struct drm_dp_mst_port *port, bool
> > > > > power_up)
> > > > >  {
> > > > >       struct drm_dp_sideband_msg_tx *txmsg;
> > > > > -     int len, ret;
> > > > > +     int ret;
> > > > > 
> > > > >       port = drm_dp_mst_topology_get_port_validated(mgr, port);
> > > > >       if (!port)
> > > > > @@ -2638,7 +2621,7 @@ int drm_dp_send_power_updown_phy(struct
> > > > > drm_dp_mst_topology_mgr *mgr,
> > > > >       }
> > > > > 
> > > > >       txmsg->dst = port->parent;
> > > > > -     len = build_power_updown_phy(txmsg, port->port_num, power_up);
> > > > > +     build_power_updown_phy(txmsg, port->port_num, power_up);
> > > > >       drm_dp_queue_down_tx(mgr, txmsg);
> > > > > 
> > > > >       ret = drm_dp_mst_wait_tx_reply(port->parent, txmsg);
> > > > > @@ -2858,7 +2841,6 @@ static int drm_dp_send_dpcd_read(struct
> > > > > drm_dp_mst_topology_mgr *mgr,
> > > > >                                struct drm_dp_mst_port *port,
> > > > >                                int offset, int size, u8 *bytes)
> > > > >  {
> > > > > -     int len;
> > > > >       int ret = 0;
> > > > >       struct drm_dp_sideband_msg_tx *txmsg;
> > > > >       struct drm_dp_mst_branch *mstb;
> > > > > @@ -2873,7 +2855,7 @@ static int drm_dp_send_dpcd_read(struct
> > > > > drm_dp_mst_topology_mgr *mgr,
> > > > >               goto fail_put;
> > > > >       }
> > > > > 
> > > > > -     len = build_dpcd_read(txmsg, port->port_num, offset, size);
> > > > > +     build_dpcd_read(txmsg, port->port_num, offset, size);
> > > > >       txmsg->dst = port->parent;
> > > > > 
> > > > >       drm_dp_queue_down_tx(mgr, txmsg);
> > > > > @@ -2911,7 +2893,6 @@ static int drm_dp_send_dpcd_write(struct
> > > > > drm_dp_mst_topology_mgr *mgr,
> > > > >                                 struct drm_dp_mst_port *port,
> > > > >                                 int offset, int size, u8 *bytes)
> > > > >  {
> > > > > -     int len;
> > > > >       int ret;
> > > > >       struct drm_dp_sideband_msg_tx *txmsg;
> > > > >       struct drm_dp_mst_branch *mstb;
> > > > > @@ -2926,7 +2907,7 @@ static int drm_dp_send_dpcd_write(struct
> > > > > drm_dp_mst_topology_mgr *mgr,
> > > > >               goto fail_put;
> > > > >       }
> > > > > 
> > > > > -     len = build_dpcd_write(txmsg, port->port_num, offset, size,
> > > > > bytes);
> > > > > +     build_dpcd_write(txmsg, port->port_num, offset, size, bytes);
> > > > >       txmsg->dst = mstb;
> > > > > 
> > > > >       drm_dp_queue_down_tx(mgr, txmsg);
> > > > > @@ -3149,7 +3130,7 @@ static bool drm_dp_get_one_sb_msg(struct
> > > > > drm_dp_mst_topology_mgr *mgr, bool up)
> > > > >  {
> > > > >       int len;
> > > > >       u8 replyblock[32];
> > > > > -     int replylen, origlen, curreply;
> > > > > +     int replylen, curreply;
> > > > >       int ret;
> > > > >       struct drm_dp_sideband_msg_rx *msg;
> > > > >       int basereg = up ? DP_SIDEBAND_MSG_UP_REQ_BASE :
> > > > > DP_SIDEBAND_MSG_DOWN_REP_BASE;
> > > > > @@ -3169,7 +3150,6 @@ static bool drm_dp_get_one_sb_msg(struct
> > > > > drm_dp_mst_topology_mgr *mgr, bool up)
> > > > >       }
> > > > >       replylen = msg->curchunk_len + msg->curchunk_hdrlen;
> > > > > 
> > > > > -     origlen = replylen;
> > > > >       replylen -= len;
> > > > >       curreply = len;
> > > > >       while (replylen > 0) {
> > > > > @@ -3961,17 +3941,16 @@ void drm_dp_mst_dump_topology(struct
> > > > > seq_file *m,
> > > > >       mutex_lock(&mgr->lock);
> > > > >       if (mgr->mst_primary) {
> > > > >               u8 buf[DP_PAYLOAD_TABLE_SIZE];
> > > > > -             int ret;
> > > > > 
> > > > > -             ret = drm_dp_dpcd_read(mgr->aux, DP_DPCD_REV, buf,
> > > > > DP_RECEIVER_CAP_SIZE);
> > > > > +             drm_dp_dpcd_read(mgr->aux, DP_DPCD_REV, buf,
> > > > > DP_RECEIVER_CAP_SIZE);
> > > > >               seq_printf(m, "dpcd: %*ph\n", DP_RECEIVER_CAP_SIZE,
> > > > > buf);
> > > > > -             ret = drm_dp_dpcd_read(mgr->aux, DP_FAUX_CAP, buf, 2);
> > > > > +             drm_dp_dpcd_read(mgr->aux, DP_FAUX_CAP, buf, 2);
> > > > >               seq_printf(m, "faux/mst: %*ph\n", 2, buf);
> > > > > -             ret = drm_dp_dpcd_read(mgr->aux, DP_MSTM_CTRL, buf,
> > > > > 1);
> > > > > +             drm_dp_dpcd_read(mgr->aux, DP_MSTM_CTRL, buf, 1);
> > > > >               seq_printf(m, "mst ctrl: %*ph\n", 1, buf);
> > > > > 
> > > > >               /* dump the standard OUI branch header */
> > > > > -             ret = drm_dp_dpcd_read(mgr->aux, DP_BRANCH_OUI, buf,
> > > > > DP_BRANCH_OUI_HEADER_SIZE);
> > > > > +             drm_dp_dpcd_read(mgr->aux, DP_BRANCH_OUI, buf,
> > > > > DP_BRANCH_OUI_HEADER_SIZE);
> > > > >               seq_printf(m, "branch oui: %*phN devid: ", 3, buf);
> > > > >               for (i = 0x3; i < 0x8 && buf[i]; i++)
> > > > >                       seq_printf(m, "%c", buf[i]);
> > > > 
> > > > --
> > > > Jani Nikula, Intel Open Source Graphics Center
> > > > _______________________________________________
> > > > dri-devel mailing list
> > > > dri-devel@lists.freedesktop.org
> > > > https://lists.freedesktop.org/mailman/listinfo/dri-devel
-- 
Cheers,
	Lyude Paul


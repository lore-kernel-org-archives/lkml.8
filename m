Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F553C35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 17:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FD092166E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 17:40:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZkQ4sJRR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbgBDRke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 12:40:34 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:46684 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727382AbgBDRke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 12:40:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580838032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GdKUqG0hlKc8NO6Hu4nHDRoDV9My0prFO6kPvxfcrQQ=;
        b=ZkQ4sJRRhpnyhl1fSqKRw1AMh3DCbMmWPEudJY42VBDXQkrHnPUqWP+kKM0WSIPCN4kd3F
        VG1zha6NoEF0BOSPVlAbUxSFuaUOd2k1q/HCH6Cs4gRcFik0RuWRtEZmD+ZJZjTaKGEeSl
        0y+EC47M6Ek7/TFmwpIJjn0UDTtyXuM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-yVxbASw6PRiTrZpwH1JZkA-1; Tue, 04 Feb 2020 12:40:30 -0500
X-MC-Unique: yVxbASw6PRiTrZpwH1JZkA-1
Received: by mail-qk1-f198.google.com with SMTP id t195so12330240qke.23
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 09:40:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=GdKUqG0hlKc8NO6Hu4nHDRoDV9My0prFO6kPvxfcrQQ=;
        b=RTRWn+TgGTPQ/UWAhF+RL2ZMq9T+BUbNSFtRtKgz0JZ93d2070vptvuU24VCZa5Rrj
         oyJpbMox9238212NXpzvDSh7/SBck+JJJO/4tsr9BGf7TIPXrJNz32cI8b7jS6Ui7pdC
         H6pDOrJydb1A595juaVI1/n6D1vwFXQgzCn7oQU+og2XJceScjudDTq9EOnArwBdJhPo
         ANmUsN7nswqwUlyt+vr/Vw30igI005k6+Ep+QLMtTWo9VdiiBrQb76eQfiKH+zcMI3a2
         UYAg0W0pfRjIp/SOZw7w8ZyaHqpKg2KOr/VuUaJoTp9pES8iTPPZQRItw5dhDMcpBkM8
         UKhg==
X-Gm-Message-State: APjAAAU2PaubTDWs3l3dp6KKiXp7j8VsRkwZoD54N1fpQRtHRooruhLl
        xE1Sb8+11YxpMOlL9h9WYyNqzphZ/x8ayYD6Y9+s1ZcsjPZqomkWguMIVyrZTl/ZY7USVboNsSb
        BYaxXGPLAiGgEe7BE2NONAajd
X-Received: by 2002:a05:620a:6d7:: with SMTP id 23mr28096046qky.299.1580838029553;
        Tue, 04 Feb 2020 09:40:29 -0800 (PST)
X-Google-Smtp-Source: APXvYqztnAJHOQVji4VAkxfVUnlN5gDsDS9CB/KMTw07K6mcIE7xTuko8PqeJjqon8GZfBLJyid1bg==
X-Received: by 2002:a05:620a:6d7:: with SMTP id 23mr28096038qky.299.1580838029268;
        Tue, 04 Feb 2020 09:40:29 -0800 (PST)
Received: from dhcp-10-20-1-90.bss.redhat.com ([144.121.20.162])
        by smtp.gmail.com with ESMTPSA id k50sm12392443qtc.90.2020.02.04.09.40.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 09:40:28 -0800 (PST)
Message-ID: <4103c73a5b9b7ba6cb5998eef3ee4c0dc8902b8a.camel@redhat.com>
Subject: Re: [PATCH v5] drm/dp_mst: Fix W=1 warnings
From:   Lyude Paul <lyude@redhat.com>
To:     Benjamin Gaignard <benjamin.gaignard@st.com>,
        jani.nikula@linux.intel.com, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Tue, 04 Feb 2020 12:40:27 -0500
In-Reply-To: <20200131100128.3927-1-benjamin.gaignard@st.com>
References: <20200131100128.3927-1-benjamin.gaignard@st.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mostly looks good, some comments below:

On Fri, 2020-01-31 at 11:01 +0100, Benjamin Gaignard wrote:
> Fix the warnings that show up with W=1.
> They are all about unused but set variables.
> If functions returns are not used anymore make them void.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
> version 5:
> - fix indentation
>   
> version 4:
> - do not touch crc4 unused variable in this patch
> CC: lyude@redhat.com
> CC: airlied@linux.ie
> CC: jani.nikula@linux.intel.com
> 
>  drivers/gpu/drm/drm_dp_mst_topology.c | 92 +++++++++++++++-----------------
> ---
>  1 file changed, 40 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 4104f15f4594..822d2f177f90 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -1034,7 +1034,8 @@ static bool drm_dp_sideband_parse_req(struct
> drm_dp_sideband_msg_rx *raw,
>  	}
>  }
>  
> -static int build_dpcd_write(struct drm_dp_sideband_msg_tx *msg, u8
> port_num, u32 offset, u8 num_bytes, u8 *bytes)
> +static void build_dpcd_write(struct drm_dp_sideband_msg_tx *msg,
> +			     u8 port_num, u32 offset, u8 num_bytes, u8 *bytes)
>  {
>  	struct drm_dp_sideband_msg_req_body req;
>  
> @@ -1044,17 +1045,14 @@ static int build_dpcd_write(struct
> drm_dp_sideband_msg_tx *msg, u8 port_num, u32
>  	req.u.dpcd_write.num_bytes = num_bytes;
>  	req.u.dpcd_write.bytes = bytes;
>  	drm_dp_encode_sideband_req(&req, msg);
> -
> -	return 0;
>  }
>  
> -static int build_link_address(struct drm_dp_sideband_msg_tx *msg)
> +static void build_link_address(struct drm_dp_sideband_msg_tx *msg)
>  {
>  	struct drm_dp_sideband_msg_req_body req;
>  
>  	req.req_type = DP_LINK_ADDRESS;
>  	drm_dp_encode_sideband_req(&req, msg);
> -	return 0;
>  }
>  
>  static int build_clear_payload_id_table(struct drm_dp_sideband_msg_tx *msg)
> @@ -1066,7 +1064,8 @@ static int build_clear_payload_id_table(struct
> drm_dp_sideband_msg_tx *msg)
>  	return 0;
>  }
>  
> -static int build_enum_path_resources(struct drm_dp_sideband_msg_tx *msg,
> int port_num)
> +static int build_enum_path_resources(struct drm_dp_sideband_msg_tx *msg,
> +				     int port_num)
>  {
>  	struct drm_dp_sideband_msg_req_body req;
>  
> @@ -1077,10 +1076,11 @@ static int build_enum_path_resources(struct
> drm_dp_sideband_msg_tx *msg, int por
>  	return 0;
>  }
>  
> -static int build_allocate_payload(struct drm_dp_sideband_msg_tx *msg, int
> port_num,
> -				  u8 vcpi, uint16_t pbn,
> -				  u8 number_sdp_streams,
> -				  u8 *sdp_stream_sink)
> +static void build_allocate_payload(struct drm_dp_sideband_msg_tx *msg,
> +				   int port_num,
> +				   u8 vcpi, uint16_t pbn,
> +				   u8 number_sdp_streams,
> +				   u8 *sdp_stream_sink)
>  {
>  	struct drm_dp_sideband_msg_req_body req;
>  	memset(&req, 0, sizeof(req));
> @@ -1093,11 +1093,10 @@ static int build_allocate_payload(struct
> drm_dp_sideband_msg_tx *msg, int port_n
>  		   number_sdp_streams);
>  	drm_dp_encode_sideband_req(&req, msg);
>  	msg->path_msg = true;
> -	return 0;
>  }
>  
> -static int build_power_updown_phy(struct drm_dp_sideband_msg_tx *msg,
> -				  int port_num, bool power_up)
> +static void build_power_updown_phy(struct drm_dp_sideband_msg_tx *msg,
> +				   int port_num, bool power_up)
>  {
>  	struct drm_dp_sideband_msg_req_body req;
>  
> @@ -1109,7 +1108,6 @@ static int build_power_updown_phy(struct
> drm_dp_sideband_msg_tx *msg,
>  	req.u.port_num.port_number = port_num;
>  	drm_dp_encode_sideband_req(&req, msg);
>  	msg->path_msg = true;
> -	return 0;
>  }
>  
>  static int drm_dp_mst_assign_payload_id(struct drm_dp_mst_topology_mgr
> *mgr,
> @@ -2054,25 +2052,20 @@ ssize_t drm_dp_mst_dpcd_write(struct drm_dp_aux
> *aux,
>  
>  static void drm_dp_check_mstb_guid(struct drm_dp_mst_branch *mstb, u8
> *guid)
>  {
> -	int ret;
> -
>  	memcpy(mstb->guid, guid, 16);
>  
>  	if (!drm_dp_validate_guid(mstb->mgr, mstb->guid)) {
>  		if (mstb->port_parent) {
> -			ret = drm_dp_send_dpcd_write(
> -					mstb->mgr,
> -					mstb->port_parent,
> -					DP_GUID,
> -					16,
> -					mstb->guid);
> +			drm_dp_send_dpcd_write(mstb->mgr,
> +					       mstb->port_parent,
> +					       DP_GUID,
> +					       16,
> +					       mstb->guid);
>  		} else {
> -
> -			ret = drm_dp_dpcd_write(
> -					mstb->mgr->aux,
> -					DP_GUID,
> -					mstb->guid,
> -					16);
> +			drm_dp_dpcd_write(mstb->mgr->aux,
> +					  DP_GUID,
> +					  mstb->guid,
> +					  16);
>  		}

I think this one we should actually pass the return code from
drm_dp_dpcd_write() back from drm_dp_check_mstb_guid(), and then check the
return code in any places where we're calling this, instead of just dropping
it.

>  	}
>  }
> @@ -2595,7 +2588,8 @@ static bool drm_dp_validate_guid(struct
> drm_dp_mst_topology_mgr *mgr,
>  	return false;
>  }
>  
> -static int build_dpcd_read(struct drm_dp_sideband_msg_tx *msg, u8 port_num,
> u32 offset, u8 num_bytes)
> +static void build_dpcd_read(struct drm_dp_sideband_msg_tx *msg,
> +			    u8 port_num, u32 offset, u8 num_bytes)
>  {
>  	struct drm_dp_sideband_msg_req_body req;
>  
> @@ -2604,8 +2598,6 @@ static int build_dpcd_read(struct
> drm_dp_sideband_msg_tx *msg, u8 port_num, u32
>  	req.u.dpcd_read.dpcd_address = offset;
>  	req.u.dpcd_read.num_bytes = num_bytes;
>  	drm_dp_encode_sideband_req(&req, msg);
> -
> -	return 0;
>  }
>  
>  static int drm_dp_send_sideband_msg(struct drm_dp_mst_topology_mgr *mgr,
> @@ -2828,7 +2820,7 @@ static int drm_dp_send_link_address(struct
> drm_dp_mst_topology_mgr *mgr,
>  	struct drm_dp_sideband_msg_tx *txmsg;
>  	struct drm_dp_link_address_ack_reply *reply;
>  	struct drm_dp_mst_port *port, *tmp;
> -	int i, len, ret, port_mask = 0;
> +	int i, ret, port_mask = 0;
>  	bool changed = false;
>  
>  	txmsg = kzalloc(sizeof(*txmsg), GFP_KERNEL);
> @@ -2836,7 +2828,7 @@ static int drm_dp_send_link_address(struct
> drm_dp_mst_topology_mgr *mgr,
>  		return -ENOMEM;
>  
>  	txmsg->dst = mstb;
> -	len = build_link_address(txmsg);
> +	build_link_address(txmsg);
>  
>  	mstb->link_address_sent = true;
>  	drm_dp_queue_down_tx(mgr, txmsg);
> @@ -2898,14 +2890,14 @@ void drm_dp_send_clear_payload_id_table(struct
> drm_dp_mst_topology_mgr *mgr,
>  					struct drm_dp_mst_branch *mstb)
>  {
>  	struct drm_dp_sideband_msg_tx *txmsg;
> -	int len, ret;
> +	int ret;
>  
>  	txmsg = kzalloc(sizeof(*txmsg), GFP_KERNEL);
>  	if (!txmsg)
>  		return;
>  
>  	txmsg->dst = mstb;
> -	len = build_clear_payload_id_table(txmsg);
> +	build_clear_payload_id_table(txmsg);
>  
>  	drm_dp_queue_down_tx(mgr, txmsg);
>  
> @@ -2923,7 +2915,6 @@ drm_dp_send_enum_path_resources(struct
> drm_dp_mst_topology_mgr *mgr,
>  {
>  	struct drm_dp_enum_path_resources_ack_reply *path_res;
>  	struct drm_dp_sideband_msg_tx *txmsg;
> -	int len;
>  	int ret;
>  
>  	txmsg = kzalloc(sizeof(*txmsg), GFP_KERNEL);
> @@ -2931,7 +2922,7 @@ drm_dp_send_enum_path_resources(struct
> drm_dp_mst_topology_mgr *mgr,
>  		return -ENOMEM;
>  
>  	txmsg->dst = mstb;
> -	len = build_enum_path_resources(txmsg, port->port_num);
> +	build_enum_path_resources(txmsg, port->port_num);
>  
>  	drm_dp_queue_down_tx(mgr, txmsg);
>  
> @@ -3014,7 +3005,7 @@ static int drm_dp_payload_send_msg(struct
> drm_dp_mst_topology_mgr *mgr,
>  {
>  	struct drm_dp_sideband_msg_tx *txmsg;
>  	struct drm_dp_mst_branch *mstb;
> -	int len, ret, port_num;
> +	int ret, port_num;
>  	u8 sinks[DRM_DP_MAX_SDP_STREAMS];
>  	int i;
>  
> @@ -3039,9 +3030,9 @@ static int drm_dp_payload_send_msg(struct
> drm_dp_mst_topology_mgr *mgr,
>  		sinks[i] = i;
>  
>  	txmsg->dst = mstb;
> -	len = build_allocate_payload(txmsg, port_num,
> -				     id,
> -				     pbn, port->num_sdp_streams, sinks);
> +	build_allocate_payload(txmsg, port_num,
> +			       id,
> +			       pbn, port->num_sdp_streams, sinks);
>  
>  	drm_dp_queue_down_tx(mgr, txmsg);
>  
> @@ -3070,7 +3061,7 @@ int drm_dp_send_power_updown_phy(struct
> drm_dp_mst_topology_mgr *mgr,
>  				 struct drm_dp_mst_port *port, bool power_up)
>  {
>  	struct drm_dp_sideband_msg_tx *txmsg;
> -	int len, ret;
> +	int ret;
>  
>  	port = drm_dp_mst_topology_get_port_validated(mgr, port);
>  	if (!port)
> @@ -3083,7 +3074,7 @@ int drm_dp_send_power_updown_phy(struct
> drm_dp_mst_topology_mgr *mgr,
>  	}
>  
>  	txmsg->dst = port->parent;
> -	len = build_power_updown_phy(txmsg, port->port_num, power_up);
> +	build_power_updown_phy(txmsg, port->port_num, power_up);
>  	drm_dp_queue_down_tx(mgr, txmsg);
>  
>  	ret = drm_dp_mst_wait_tx_reply(port->parent, txmsg);
> @@ -3305,7 +3296,6 @@ static int drm_dp_send_dpcd_read(struct
> drm_dp_mst_topology_mgr *mgr,
>  				 struct drm_dp_mst_port *port,
>  				 int offset, int size, u8 *bytes)
>  {
> -	int len;
>  	int ret = 0;
>  	struct drm_dp_sideband_msg_tx *txmsg;
>  	struct drm_dp_mst_branch *mstb;
> @@ -3320,7 +3310,7 @@ static int drm_dp_send_dpcd_read(struct
> drm_dp_mst_topology_mgr *mgr,
>  		goto fail_put;
>  	}
>  
> -	len = build_dpcd_read(txmsg, port->port_num, offset, size);
> +	build_dpcd_read(txmsg, port->port_num, offset, size);
>  	txmsg->dst = port->parent;
>  
>  	drm_dp_queue_down_tx(mgr, txmsg);
> @@ -3358,7 +3348,6 @@ static int drm_dp_send_dpcd_write(struct
> drm_dp_mst_topology_mgr *mgr,
>  				  struct drm_dp_mst_port *port,
>  				  int offset, int size, u8 *bytes)
>  {
> -	int len;
>  	int ret;
>  	struct drm_dp_sideband_msg_tx *txmsg;
>  	struct drm_dp_mst_branch *mstb;
> @@ -3373,7 +3362,7 @@ static int drm_dp_send_dpcd_write(struct
> drm_dp_mst_topology_mgr *mgr,
>  		goto fail_put;
>  	}
>  
> -	len = build_dpcd_write(txmsg, port->port_num, offset, size, bytes);
> +	build_dpcd_write(txmsg, port->port_num, offset, size, bytes);
>  	txmsg->dst = mstb;
>  
>  	drm_dp_queue_down_tx(mgr, txmsg);
> @@ -4529,17 +4518,16 @@ void drm_dp_mst_dump_topology(struct seq_file *m,
>  	mutex_lock(&mgr->lock);
>  	if (mgr->mst_primary) {
>  		u8 buf[DP_PAYLOAD_TABLE_SIZE];
> -		int ret;
>  
> -		ret = drm_dp_dpcd_read(mgr->aux, DP_DPCD_REV, buf,
> DP_RECEIVER_CAP_SIZE);
> +		drm_dp_dpcd_read(mgr->aux, DP_DPCD_REV, buf,
> DP_RECEIVER_CAP_SIZE);
>  		seq_printf(m, "dpcd: %*ph\n", DP_RECEIVER_CAP_SIZE, buf);
> -		ret = drm_dp_dpcd_read(mgr->aux, DP_FAUX_CAP, buf, 2);
> +		drm_dp_dpcd_read(mgr->aux, DP_FAUX_CAP, buf, 2);
>  		seq_printf(m, "faux/mst: %*ph\n", 2, buf);
> -		ret = drm_dp_dpcd_read(mgr->aux, DP_MSTM_CTRL, buf, 1);
> +		drm_dp_dpcd_read(mgr->aux, DP_MSTM_CTRL, buf, 1);
>  		seq_printf(m, "mst ctrl: %*ph\n", 1, buf);

Same for this one, would be better to maybe return with an error code or make
it obvious in the seq_printf() output that the drm_dp_dpcd_read() calls failed
since otherwise we might just end up printing out garbage.

With those two changed and split into separate patches, this patch is:

Reviewed-by: Lyude Paul <lyude@redhat.com>
>  
>  		/* dump the standard OUI branch header */
> -		ret = drm_dp_dpcd_read(mgr->aux, DP_BRANCH_OUI, buf,
> DP_BRANCH_OUI_HEADER_SIZE);
> +		drm_dp_dpcd_read(mgr->aux, DP_BRANCH_OUI, buf,
> DP_BRANCH_OUI_HEADER_SIZE);
>  		seq_printf(m, "branch oui: %*phN devid: ", 3, buf);
>  		for (i = 0x3; i < 0x8 && buf[i]; i++)
>  			seq_printf(m, "%c", buf[i]);
-- 
Cheers,
	Lyude Paul


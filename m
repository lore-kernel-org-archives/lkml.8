Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFCEC3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 11:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 317CA246A3
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 11:03:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="hgusxU3S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgB1LDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 06:03:36 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42104 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbgB1LDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 06:03:35 -0500
Received: by mail-wr1-f65.google.com with SMTP id p18so2430075wre.9
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 03:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tIj3gme9XHR/3amZRjYhLO6cJtss0/lzE+AjL+bHEMw=;
        b=hgusxU3SM+AqZmB61xlexU7vQzofwM5FlHw9VmUFDoqv7OC2MHii6y1bXC2S4ydc4X
         ys9uylj25tUSEu6Wv2dcb/sgzQpWS8qNk2TMYnrmnhjJMQE3Zst3AIBrHsnL9f4hcZa/
         XNHvktx73vIcPf3+yaApUybh7iz6yJpY+DySr5NpSk5gL2f1NcW643jV9VA67+9esrl4
         VewPftJfpLofoPSaPjBSdfcOTZJX9aIpcmY4aAUDn15V1BeIVhuWYyVG0o6Ss7wYzdh/
         gTli2fYNM2j8ZHDktV1e0RjjqHkUr6rFPwOHNb2CZBQrrK8wQyc3PZ095Gt9QYnn3hdi
         cDYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tIj3gme9XHR/3amZRjYhLO6cJtss0/lzE+AjL+bHEMw=;
        b=Pdr11vXHabkGdGcwW9Q/vxNymXkpsJSvYma1eQuiq8yIP0+8bcBI6UWuqkssW+ohR+
         cx4ttBont96cHzR5MjtjAGulLt9kDigb1Srpeq3+JIOZn5YtjA/WQwgkxLyNu3BsPrrJ
         SHAlRA/keEWQd+h7oZvGUO23HWEarkLC9ekdzcxYWE7zYZuEzHkYSWqq8j0XbKD0eKl0
         FusiGUfVAFPvcJrk2QzFl8w01TjU/U+v/5f2hzTV91Gb5jznhne2vBiMrvEPPtjsQPJc
         3yMArOXyMBb0CSAxDNPOasrbNHllYEV89bX9PD86yOU2VRkJmI4DHWGpH6/+DwYcqsdu
         Cp/Q==
X-Gm-Message-State: APjAAAVV6QDXg4s4N/bEyf59F19OzB0gin5ZGzLvcVVGTvqCZzMlHw0l
        T6e0H6zWoMEq8RPQ9aWZXBmmEQ==
X-Google-Smtp-Source: APXvYqxgV911niRv4BkflCHF+xunY8kdAkFKZzO7USFg0ONpuK7z/eB+eSZp9VRQkx2YJVP/nJtQ0Q==
X-Received: by 2002:a5d:4984:: with SMTP id r4mr4227689wrq.137.1582887813552;
        Fri, 28 Feb 2020 03:03:33 -0800 (PST)
Received: from localhost (ip-89-177-130-96.net.upcbroadband.cz. [89.177.130.96])
        by smtp.gmail.com with ESMTPSA id b14sm1357586wrn.75.2020.02.28.03.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 03:03:33 -0800 (PST)
Date:   Fri, 28 Feb 2020 12:03:32 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Oleksandr Mazur <oleksandr.mazur@plvision.eu>,
        Taras Chornyi <taras.chornyi@plvision.eu>,
        Serhiy Boiko <serhiy.boiko@plvision.eu>,
        Andrii Savka <andrii.savka@plvision.eu>,
        Volodymyr Mytnyk <volodymyr.mytnyk@plvision.eu>,
        Serhiy Pshyk <serhiy.pshyk@plvision.eu>
Subject: Re: [RFC net-next 1/3] net: marvell: prestera: Add Switchdev driver
 for Prestera family ASIC device 98DX325x (AC3x)
Message-ID: <20200228110332.GK26061@nanopsycho>
References: <20200225163025.9430-1-vadym.kochan@plvision.eu>
 <20200225163025.9430-2-vadym.kochan@plvision.eu>
 <20200227142259.GF26061@nanopsycho>
 <20200228080554.GA17929@plvision.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228080554.GA17929@plvision.eu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Feb 28, 2020 at 09:06:02AM CET, vadym.kochan@plvision.eu wrote:
>Hi Jiri,
>
>On Thu, Feb 27, 2020 at 03:22:59PM +0100, Jiri Pirko wrote:
>> Tue, Feb 25, 2020 at 05:30:54PM CET, vadym.kochan@plvision.eu wrote:
>> >Marvell Prestera 98DX326x integrates up to 24 ports of 1GbE with 8
>> >ports of 10GbE uplinks or 2 ports of 40Gbps stacking for a largely
>> >wireless SMB deployment.
>> >
>> >This driver implementation includes only L1 & basic L2 support.
>> >
>> >The core Prestera switching logic is implemented in prestera.c, there is
>> >an intermediate hw layer between core logic and firmware. It is
>> >implemented in prestera_hw.c, the purpose of it is to encapsulate hw
>> >related logic, in future there is a plan to support more devices with
>> >different HW related configurations.
>> >
>> >The following Switchdev features are supported:
>> >
>> >    - VLAN-aware bridge offloading
>> >    - VLAN-unaware bridge offloading
>> >    - FDB offloading (learning, ageing)
>> >    - Switchport configuration
>> >
>> >Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
>> >Signed-off-by: Andrii Savka <andrii.savka@plvision.eu>
>> >Signed-off-by: Oleksandr Mazur <oleksandr.mazur@plvision.eu>
>> >Signed-off-by: Serhiy Boiko <serhiy.boiko@plvision.eu>
>> >Signed-off-by: Serhiy Pshyk <serhiy.pshyk@plvision.eu>
>> >Signed-off-by: Taras Chornyi <taras.chornyi@plvision.eu>
>> >Signed-off-by: Volodymyr Mytnyk <volodymyr.mytnyk@plvision.eu>
>> >---
>
>[SNIP]
>
>> >+};
>> >+
>> >+struct mvsw_msg_cmd {
>> >+	u32 type;
>> >+} __packed __aligned(4);
>> >+
>> >+struct mvsw_msg_ret {
>> >+	struct mvsw_msg_cmd cmd;
>> >+	u32 status;
>> >+} __packed __aligned(4);
>> >+
>> >+struct mvsw_msg_common_request {
>> >+	struct mvsw_msg_cmd cmd;
>> >+} __packed __aligned(4);
>> >+
>> >+struct mvsw_msg_common_response {
>> >+	struct mvsw_msg_ret ret;
>> >+} __packed __aligned(4);
>> >+
>> >+union mvsw_msg_switch_param {
>> >+	u32 ageing_timeout;
>> >+};
>> >+
>> >+struct mvsw_msg_switch_attr_cmd {
>> >+	struct mvsw_msg_cmd cmd;
>> >+	union mvsw_msg_switch_param param;
>> >+} __packed __aligned(4);
>> >+
>> >+struct mvsw_msg_switch_init_ret {
>> >+	struct mvsw_msg_ret ret;
>> >+	u32 port_count;
>> >+	u32 mtu_max;
>> >+	u8  switch_id;
>> >+	u8  mac[ETH_ALEN];
>> >+} __packed __aligned(4);
>> >+
>> >+struct mvsw_msg_port_autoneg_param {
>> >+	u64 link_mode;
>> >+	u8  enable;
>> >+	u8  fec;
>> >+};
>> >+
>> >+struct mvsw_msg_port_cap_param {
>> >+	u64 link_mode;
>> >+	u8  type;
>> >+	u8  fec;
>> >+	u8  transceiver;
>> >+};
>> >+
>> >+union mvsw_msg_port_param {
>> >+	u8  admin_state;
>> >+	u8  oper_state;
>> >+	u32 mtu;
>> >+	u8  mac[ETH_ALEN];
>> >+	u8  accept_frm_type;
>> >+	u8  learning;
>> >+	u32 speed;
>> >+	u8  flood;
>> >+	u32 link_mode;
>> >+	u8  type;
>> >+	u8  duplex;
>> >+	u8  fec;
>> >+	u8  mdix;
>> >+	struct mvsw_msg_port_autoneg_param autoneg;
>> >+	struct mvsw_msg_port_cap_param cap;
>> >+};
>> >+
>> >+struct mvsw_msg_port_attr_cmd {
>> >+	struct mvsw_msg_cmd cmd;
>> >+	u32 attr;
>> >+	u32 port;
>> >+	u32 dev;
>> >+	union mvsw_msg_port_param param;
>> >+} __packed __aligned(4);
>> >+
>> >+struct mvsw_msg_port_attr_ret {
>> >+	struct mvsw_msg_ret ret;
>> >+	union mvsw_msg_port_param param;
>> >+} __packed __aligned(4);
>> >+
>> >+struct mvsw_msg_port_stats_ret {
>> >+	struct mvsw_msg_ret ret;
>> >+	u64 stats[MVSW_PORT_CNT_MAX];
>> >+} __packed __aligned(4);
>> >+
>> >+struct mvsw_msg_port_info_cmd {
>> >+	struct mvsw_msg_cmd cmd;
>> >+	u32 port;
>> >+} __packed __aligned(4);
>> >+
>> >+struct mvsw_msg_port_info_ret {
>> >+	struct mvsw_msg_ret ret;
>> >+	u32 hw_id;
>> >+	u32 dev_id;
>> >+	u16 fp_id;
>> >+} __packed __aligned(4);
>> >+
>> >+struct mvsw_msg_vlan_cmd {
>> >+	struct mvsw_msg_cmd cmd;
>> >+	u32 port;
>> >+	u32 dev;
>> >+	u16 vid;
>> >+	u8  is_member;
>> >+	u8  is_tagged;
>> >+} __packed __aligned(4);
>> >+
>> >+struct mvsw_msg_fdb_cmd {
>> >+	struct mvsw_msg_cmd cmd;
>> >+	u32 port;
>> >+	u32 dev;
>> >+	u8  mac[ETH_ALEN];
>> >+	u16 vid;
>> >+	u8  dynamic;
>> >+	u32 flush_mode;
>> >+} __packed __aligned(4);
>> >+
>> >+struct mvsw_msg_event {
>> >+	u16 type;
>> >+	u16 id;
>> >+} __packed __aligned(4);
>> >+
>> >+union mvsw_msg_event_fdb_param {
>> >+	u8 mac[ETH_ALEN];
>> >+};
>> >+
>> >+struct mvsw_msg_event_fdb {
>> >+	struct mvsw_msg_event id;
>> >+	u32 port_id;
>> >+	u32 vid;
>> >+	union mvsw_msg_event_fdb_param param;
>> >+} __packed __aligned(4);
>> >+
>> >+union mvsw_msg_event_port_param {
>> >+	u32 oper_state;
>> >+};
>> >+
>> >+struct mvsw_msg_event_port {
>> >+	struct mvsw_msg_event id;
>> >+	u32 port_id;
>> >+	union mvsw_msg_event_port_param param;
>> >+} __packed __aligned(4);
>> >+
>> >+struct mvsw_msg_bridge_cmd {
>> >+	struct mvsw_msg_cmd cmd;
>> >+	u32 port;
>> >+	u32 dev;
>> >+	u16 bridge;
>> >+} __packed __aligned(4);
>> >+
>> >+struct mvsw_msg_bridge_ret {
>> >+	struct mvsw_msg_ret ret;
>> >+	u16 bridge;
>> >+} __packed __aligned(4);
>> >+
>> >+#define fw_check_resp(_response)	\
>> >+({								\
>> >+	int __er = 0;						\
>> >+	typeof(_response) __r = (_response);			\
>> >+	if (__r->ret.cmd.type != MVSW_MSG_TYPE_ACK)		\
>> >+		__er = -EBADE;					\
>> >+	else if (__r->ret.status != MVSW_MSG_ACK_OK)		\
>> >+		__er = -EINVAL;					\
>> >+	(__er);							\
>> >+})
>> >+
>> >+#define __fw_send_req_resp(_switch, _type, _request, _response, _wait)	\
>> 
>> Please try to avoid doing functions in macros like this one and the
>> previous one.
>> 
>> 
>> >+({								\
>> >+	int __e;						\
>> >+	typeof(_switch) __sw = (_switch);			\
>> >+	typeof(_request) __req = (_request);			\
>> >+	typeof(_response) __resp = (_response);			\
>> >+	__req->cmd.type = (_type);				\
>> >+	__e = __sw->dev->send_req(__sw->dev,			\
>> >+		(u8 *)__req, sizeof(*__req),			\
>> >+		(u8 *)__resp, sizeof(*__resp),			\
>> >+		_wait);						\
>> >+	if (!__e)						\
>> >+		__e = fw_check_resp(__resp);			\
>> >+	(__e);							\
>> >+})
>> >+
>> >+#define fw_send_req_resp(_sw, _t, _req, _resp)	\
>> >+	__fw_send_req_resp(_sw, _t, _req, _resp, 0)
>> >+
>> >+#define fw_send_req_resp_wait(_sw, _t, _req, _resp, _wait)	\
>> >+	__fw_send_req_resp(_sw, _t, _req, _resp, _wait)
>> >+
>> >+#define fw_send_req(_sw, _t, _req)	\
>> 
>> This should be function, not define
>
>Yeah, I understand your point, but here was the reason:
>
>all packed structs which defined here in prestera_hw.c
>are used for transmission request/return to/from the firmware, each of
>the struct requires to have req/ret member (depends if it is request or
>return from the firmware), and the purpose of the macro is to avoid case
>when someone can forget to add req/ret member to the new such structure.

You should refactor your code to make this cleaner. Define acting as
a function working with random structures counting with 2 member names in
them, that is not nice :/


>
>> 
>> 
>> >+({							\
>> >+	struct mvsw_msg_common_response __re;		\
>> >+	(fw_send_req_resp(_sw, _t, _req, &__re));	\
>> >+})
>> >+
>
>Regards,
>Vadym Kochan,

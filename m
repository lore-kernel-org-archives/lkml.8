Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04DAC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 08:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96405206F6
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 08:34:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="crnPojX6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgGZIeS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 04:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgGZIeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 04:34:17 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1A5C0619D4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 01:34:17 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a5so1928478wrm.6
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 01:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n9kylY7GuTi1hpiXblVE/pILyMHgneAzHx0O8M6wx84=;
        b=crnPojX6GjGIjlMTCTlUTXM5ajsUgp0tYTs0thQpZ5X0kNgCgk9+can8dneymfowNa
         VjM7PuRja7iNb2s7WK1nZsun4RQF/LkeHkOElu90RAtO067wJbcDH/dvy1vU3O+zxTNf
         EtbmWAx8oaJOeXVFgrkIOtoVrKAfa7nZeYyo1YvzHbExV91wLwbkkyKsAqYIkv4bGXkD
         Z3gZB2NVaBnf4FCr/MTmOPf/qzwjqz4pDDFZ83fRIpZfFGHnWBkHK3gC0wT7BmDHUkda
         nXXKb9D+Y2T9CXvxfW5u63z2DnK3dQj9v5Y1Ql2bpQuEncEpJc+5Ii7cj+xuR5D39N2A
         3ybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n9kylY7GuTi1hpiXblVE/pILyMHgneAzHx0O8M6wx84=;
        b=GxxS7j4gZ7Gjju7iBk7V7L4j4Ehw/tx8kyewD1nmrMM242ZMSwt59GqR5c8keTCK6D
         i8AQR1n9PBD6npokHN/x/p2aGGhd/MEjoUG9UX2AOd2oQQd31+efLWNLWoEcyhwS7h71
         LYjLyL2JRmkuDUZ0RWE9dZYTROzH7AHnzBMt1CA2getR7oM8Vv6UFFzG4E1UfKaeqqOa
         JTcUgjL8aXrxYlJxtX7cyws6Tvh5UUhtdjdBIO2RjJn9iPZ6mTpyxL7K0dSEiLUJE3xy
         EM4UknpF9DWaSjdR+AVKiqV7Kvqb3hKYikKa3ZTg0u5a2/CM5SFKbFuLamei/OQKlvh1
         tmAA==
X-Gm-Message-State: AOAM533IfB51MT8No5AFVaQWRrdCkw5nm/4Ym6ty4EOLxNmhxx8+IXEt
        Nb7KDy12/UZB/98SxAZQVV+hew==
X-Google-Smtp-Source: ABdhPJyLeHHv4S9T73dvJ9HiRna2wOkaIlDDFqVYgx49cElOvg2ZwAn6ZV7pJQuMGpuJLjOIdUD0pg==
X-Received: by 2002:a05:6000:1206:: with SMTP id e6mr15334554wrx.346.1595752456222;
        Sun, 26 Jul 2020 01:34:16 -0700 (PDT)
Received: from localhost (jirka.pirko.cz. [84.16.102.26])
        by smtp.gmail.com with ESMTPSA id k4sm8261233wrd.72.2020.07.26.01.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2020 01:34:15 -0700 (PDT)
Date:   Sun, 26 Jul 2020 10:34:14 +0200
From:   Jiri Pirko <jiri@resnulli.us>
To:     Vadym Kochan <vadym.kochan@plvision.eu>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Oleksandr Mazur <oleksandr.mazur@plvision.eu>,
        Serhiy Boiko <serhiy.boiko@plvision.eu>,
        Serhiy Pshyk <serhiy.pshyk@plvision.eu>,
        Volodymyr Mytnyk <volodymyr.mytnyk@plvision.eu>,
        Taras Chornyi <taras.chornyi@plvision.eu>,
        Andrii Savka <andrii.savka@plvision.eu>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mickey Rachamim <mickeyr@marvell.com>
Subject: Re: [net-next v3 5/6] net: marvell: prestera: Add Switchdev driver
 implementation
Message-ID: <20200726083414.GD2216@nanopsycho>
References: <20200725150651.17029-1-vadym.kochan@plvision.eu>
 <20200725150651.17029-6-vadym.kochan@plvision.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200725150651.17029-6-vadym.kochan@plvision.eu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sat, Jul 25, 2020 at 05:06:50PM CEST, vadym.kochan@plvision.eu wrote:
>The following features are supported:
>
>    - VLAN-aware bridge offloading
>    - VLAN-unaware bridge offloading
>    - FDB offloading (learning, ageing)
>    - Switchport configuration
>
>Currently there are some limitations like:
>
>    - Only 1 VLAN-aware bridge instance supported
>    - FDB ageing timeout parameter is set globally per device
>
>Signed-off-by: Serhiy Boiko <serhiy.boiko@plvision.eu>
>Signed-off-by: Serhiy Pshyk <serhiy.pshyk@plvision.eu>
>Signed-off-by: Taras Chornyi <taras.chornyi@plvision.eu>
>Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
>---

[...]


>+static void prestera_fdb_event_work(struct work_struct *work)
>+{
>+	struct switchdev_notifier_fdb_info *fdb_info;
>+	struct prestera_fdb_event_work *swdev_work;
>+	struct prestera_port *port;
>+	struct net_device *dev;
>+	int err = 0;
>+
>+	swdev_work = container_of(work, struct prestera_fdb_event_work, work);
>+	dev = swdev_work->dev;
>+
>+	rtnl_lock();
>+
>+	port = prestera_port_dev_lower_find(dev);
>+	if (!port)
>+		goto out;
>+
>+	switch (swdev_work->event) {
>+	case SWITCHDEV_FDB_ADD_TO_DEVICE:
>+		fdb_info = &swdev_work->fdb_info;
>+		if (!fdb_info->added_by_user)
>+			break;
>+
>+		err = prestera_port_fdb_set(port, fdb_info, true);
>+		if (err)
>+			break;
>+
>+		prestera_fdb_offload_notify(port, fdb_info);
>+		break;
>+
>+	case SWITCHDEV_FDB_DEL_TO_DEVICE:
>+		fdb_info = &swdev_work->fdb_info;
>+		prestera_port_fdb_set(port, fdb_info, false);
>+		break;
>+	}
>+
>+out:
>+	rtnl_unlock();
>+
>+	kfree(swdev_work->fdb_info.addr);
>+	kfree(swdev_work);
>+	dev_put(dev);
>+}
>+
>+static int prestera_switchdev_event(struct notifier_block *unused,
>+				    unsigned long event, void *ptr)
>+{
>+	struct net_device *dev = switchdev_notifier_info_to_dev(ptr);
>+	struct switchdev_notifier_fdb_info *fdb_info;
>+	struct switchdev_notifier_info *info = ptr;
>+	struct prestera_fdb_event_work *swdev_work;
>+	struct net_device *upper;
>+	int err = 0;
>+
>+	if (event == SWITCHDEV_PORT_ATTR_SET) {
>+		err = switchdev_handle_port_attr_set(dev, ptr,
>+						     prestera_netdev_check,
>+						     prestera_port_obj_attr_set);
>+		return notifier_from_errno(err);
>+	}
>+
>+	upper = netdev_master_upper_dev_get_rcu(dev);
>+	if (!upper)
>+		return NOTIFY_DONE;
>+
>+	if (!netif_is_bridge_master(upper))
>+		return NOTIFY_DONE;

Okay, you support upper bridge. Of which interface? I believe you should
put prestera_netdev_check(dev) check here and avoid the lookup in the
work. Otherwise any chain of intermediate lower devices would be
supported, which is wrong.


>+
>+	swdev_work = kzalloc(sizeof(*swdev_work), GFP_ATOMIC);
>+	if (!swdev_work)
>+		return NOTIFY_BAD;
>+
>+	swdev_work->event = event;
>+	swdev_work->dev = dev;
>+
>+	switch (event) {
>+	case SWITCHDEV_FDB_ADD_TO_DEVICE:
>+	case SWITCHDEV_FDB_DEL_TO_DEVICE:
>+		fdb_info = container_of(info,
>+					struct switchdev_notifier_fdb_info,
>+					info);
>+
>+		INIT_WORK(&swdev_work->work, prestera_fdb_event_work);
>+		memcpy(&swdev_work->fdb_info, ptr,
>+		       sizeof(swdev_work->fdb_info));
>+
>+		swdev_work->fdb_info.addr = kzalloc(ETH_ALEN, GFP_ATOMIC);
>+		if (!swdev_work->fdb_info.addr)
>+			goto out;
>+
>+		ether_addr_copy((u8 *)swdev_work->fdb_info.addr,
>+				fdb_info->addr);
>+		dev_hold(dev);
>+
>+		break;
>+
>+	default:
>+		kfree(swdev_work);
>+		return NOTIFY_DONE;
>+	}
>+
>+	queue_work(swdev_wq, &swdev_work->work);
>+	return NOTIFY_DONE;
>+out:
>+	kfree(swdev_work);
>+	return NOTIFY_BAD;
>+}

[...]

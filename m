Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F18BC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:58:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46FA92078B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599728321;
	bh=W3vn6IPX3x4GVD5wLkm0rOKmsSB3t0SDi1WFavSkmBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SmEZMGrqoQISg1eOz6Wc8ECCDDXCClsLzQ745EYOGdG07b63ozjQet79Vu6nxHewn
	 j3VWye4TzwYBHOJ+I1RnQ9Wsz4ExMLjQIoXoNBC+q3d2vqVW6VDYl8P/49h+mBurdH
	 peEWVcQ/WHfXi3Tbe8p90XzG0bnd2+p/G9QSezts=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730520AbgIJI6j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:58:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:37480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730269AbgIJI4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:56:36 -0400
Received: from localhost (unknown [122.179.50.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14DE420795;
        Thu, 10 Sep 2020 08:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599728193;
        bh=W3vn6IPX3x4GVD5wLkm0rOKmsSB3t0SDi1WFavSkmBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xX5gJvPE3VQkbMWyrdAVGi6va/lGWrlV0vP3lDBsGO75pS7K4OynYGmUrI2V/0Sk+
         ot73jMr0fQeOPQZK/x9YAj50iADANGEUtaIuG1XJFLN7y4o8keq7eBFFkwcq74gRXR
         xhaQN4IehDjFgdIWeWEJO4kiuaP2Dgxg6CFX3krU=
Date:   Thu, 10 Sep 2020 14:26:21 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        yung-chuan.liao@linux.intel.com, sanyog.r.kale@intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soundwire: bus: add enumerated slave to device list
Message-ID: <20200910085621.GS77521@vkoul-mobl>
References: <20200909082711.11670-1-srinivas.kandagatla@linaro.org>
 <80081c70-9137-c9f0-9813-8166275ef7af@linux.intel.com>
 <ab107351-dbde-7f6d-c588-11572aed5d2d@linaro.org>
 <4cdcda10-bdc6-211f-d279-e74f57684b79@linux.intel.com>
 <d0c71a83-9dc1-83c3-5cb1-d8fb7dc7f809@linaro.org>
 <ed88432c-e21c-b5fc-3abc-5f574769b722@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed88432c-e21c-b5fc-3abc-5f574769b722@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-09-20, 12:00, Pierre-Louis Bossart wrote:
> On 9/9/20 10:54 AM, Srinivas Kandagatla wrote:
> > On 09/09/2020 15:39, Pierre-Louis Bossart wrote:
> > > 
> > > > > > Currently slave devices are only added either from device tree or acpi
> > > > > > entries. However lets say, there is wrong or no entry of
> > > > > > a slave device
> > > > > > in DT that is enumerated, then there is no way for user to know all
> > > > > > the enumerated devices on the bus.
> > > > > 
> > > > > Sorry Srinivas, I don't understand your point.
> > > > > 
> > > > > The sysfs entries will include all devices that are
> > > > > described in platform firmware (be it DT or ACPI).
> > > > 
> > > > yes that is true, but it will not include all the enumerated
> > > > devices on the bus!
> > > > 
> > > > In my case on a new board I was trying to figure out what
> > > > devices are on the bus even before even adding any device tree
> > > > entries!
> > > 
> > > We've seen this before but dynamic debug provides all the
> > > information you need. see e.g. the logs from
> > > https://sof-ci.01.org/linuxpr/PR2425/build4447/devicetest/
> > > 
> > > jf-cml-rvp-sdw-1 kernel: [  289.751974] soundwire sdw-master-0:
> > > Slave attached, programming device number
> > > jf-cml-rvp-sdw-1 kernel: [  289.752121] soundwire sdw-master-0: SDW
> > > Slave Addr: 10025d070000 <<< HERE
> > 
> > Yes, I have noticed this too! This will be printed for every call to
> > sdw_extract_slave_id()!
> > 
> > ...
> > > 
> > > Now I get your point but
> > > a) you already have a dynamic debug trace to list all devices
> > > b) adding 'undeclared' devices would make things quite murky and is
> > > only half of the solution. We already struggle because we already
> > > have 'ghost' devices in sysfs that are not physically present, and
> > > no way to differentiate between the two. If we did add those
> > > entries, then we'd need two new sysfs attributes such as
> > > 'declared' and 'enumerated'.
> > 
> > I totally agree with you on dealing with the undeclared devices, which
> > is unnecessary mess!
> 
> It's not necessarily that bad.
> - if the intent is to have a single platform firmware that can deal with
> different boards, it's a good thing.
> - but if it's just sloppy platform firmware that just does copy-paste from
> platform to platform then indeed it becomes a mess.
> 
> > May be we could make the enumerated devices discovery bit more verbose!
> 
> Maybe adding a device number sysfs entry would help, e.g. reporting
> NotAttched or a value in [0,11] would tell you if the device is actually
> present.

Agreed, I cooked this patch to report verbose device status, let me know
if you are okay with this. I think this would be useful regardless of
current discussion.

On Db845c I see:

root@linaro-alip:/sys/bus/soundwire/devices# cat sdw:0:217:2010:0:1/status
Attached
root@linaro-alip:/sys/bus/soundwire/devices# cat sdw:0:217:2010:0:2/status
Attached

diff --git a/drivers/soundwire/sysfs_slave.c b/drivers/soundwire/sysfs_slave.c
index f510071b0add..3b2765f10024 100644
--- a/drivers/soundwire/sysfs_slave.c
+++ b/drivers/soundwire/sysfs_slave.c
@@ -97,8 +97,27 @@ static ssize_t modalias_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(modalias);
 
+#define SDW_SLAVE_MAX (SDW_SLAVE_RESERVED + 1)
+
+static const char *const slave_status[SDW_SLAVE_MAX] = {
+	[SDW_SLAVE_UNATTACHED] =  "UNATTACHED",
+	[SDW_SLAVE_ATTACHED] = "Attached",
+	[SDW_SLAVE_ALERT] = "Alert",
+	[SDW_SLAVE_RESERVED] = "Reserved",
+};
+
+static ssize_t status_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
+{
+	struct sdw_slave *slave = dev_to_sdw_dev(dev);
+
+	return sprintf(buf, "%s\n", slave_status[slave->status]);
+}
+static DEVICE_ATTR_RO(status);
+
 static struct attribute *slave_attrs[] = {
 	&dev_attr_modalias.attr,
+	&dev_attr_status.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(slave);

-- 
~Vinod

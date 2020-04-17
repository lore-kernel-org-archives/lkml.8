Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C00EC2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 17:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A1D320780
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 17:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="SjDrul+G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730140AbgDQRsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 13:48:43 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:39903 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729736AbgDQRsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 13:48:42 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587145721; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=sN1KGMlgseijcBMFgDvpDzEuyZDuDmpUlOblDIwo/s0=;
 b=SjDrul+GXqA2PSrTIujj2ecNijq9NOz7EZ1Q4XMg3NmXzuWT30SiTr88q25ZMZdvtGt9xh0G
 17MeHrtwrBkM9R0uu6djf8u3XMh82z0pcBIwn+LYWMqMYI+/gzzrACuRexPftsNBLvblfVGA
 xnaaDLfCV+lbdcbkMp/+uW2CHAE=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e99ebe4.7f3ea96e7ab0-smtp-out-n04;
 Fri, 17 Apr 2020 17:48:20 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0C5D1C4478C; Fri, 17 Apr 2020 17:48:19 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: rishabhb)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 25E3AC44788;
        Fri, 17 Apr 2020 17:48:18 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 17 Apr 2020 10:48:18 -0700
From:   rishabhb@codeaurora.org
To:     Loic PALLARDY <loic.pallardy@st.com>
Cc:     linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, ohad@wizery.com,
        mathieu.poirier@linaro.org, tsoni@codeaurora.org,
        psodagud@codeaurora.org, sidgup@codeaurora.org
Subject: Re: [PATCH 3/3] remoteproc: Add coredump sysfs attribute
In-Reply-To: <8b807eab057e4dfabbc48d31cbf0b4cc@SFHDAG7NODE2.st.com>
References: <1587062312-4939-1-git-send-email-rishabhb@codeaurora.org>
 <1587062312-4939-3-git-send-email-rishabhb@codeaurora.org>
 <8b807eab057e4dfabbc48d31cbf0b4cc@SFHDAG7NODE2.st.com>
Message-ID: <3c115358fd10ac728559d876976ed391@codeaurora.org>
X-Sender: rishabhb@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-17 00:54, Loic PALLARDY wrote:
> Hi Rishabh,
> 
>> -----Original Message-----
>> From: linux-remoteproc-owner@vger.kernel.org <linux-remoteproc-
>> owner@vger.kernel.org> On Behalf Of Rishabh Bhatnagar
>> Sent: jeudi 16 avril 2020 20:39
>> To: linux-remoteproc@vger.kernel.org; linux-kernel@vger.kernel.org
>> Cc: bjorn.andersson@linaro.org; ohad@wizery.com;
>> mathieu.poirier@linaro.org; tsoni@codeaurora.org;
>> psodagud@codeaurora.org; sidgup@codeaurora.org; Rishabh Bhatnagar
>> <rishabhb@codeaurora.org>
>> Subject: [PATCH 3/3] remoteproc: Add coredump sysfs attribute
>> 
>> Add coredump sysfs attribute to configure the type of memory dump.
>> User can select between default or inline coredump functionality.
>> Also coredump collection can be disabled through this interface.
>> This functionality can be configured differently for different
>> remote processors.
>> This provides an option to dynamically configure the dump type
>> based on userpsace capability.
> I think this should be under debugfs as it is not link to remoteproc
> control but only
> to its debug capability. Moreover other fields related to coredump are
> already un debugfs control.
> 
> Regards,
> Loic
Hi Loic,
We initially thought of that but the problem is that debugfs is not
mounted for production builds. So we would be limited to only default
coredump and loose the capability to disable/move to inline coredump.
>> 
>> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
>> ---
>>  drivers/remoteproc/remoteproc_sysfs.c | 57
>> +++++++++++++++++++++++++++++++++++
>>  1 file changed, 57 insertions(+)
>> 
>> diff --git a/drivers/remoteproc/remoteproc_sysfs.c
>> b/drivers/remoteproc/remoteproc_sysfs.c
>> index 7f8536b..d112664 100644
>> --- a/drivers/remoteproc/remoteproc_sysfs.c
>> +++ b/drivers/remoteproc/remoteproc_sysfs.c
>> @@ -9,6 +9,62 @@
>> 
>>  #define to_rproc(d) container_of(d, struct rproc, dev)
>> 
>> +/*
>> + * A coredump-configuration-to-string lookup table, for exposing a
>> + * human readable configuration via sysfs. Always keep in sync with
>> + * enum rproc_coredump_conf
>> + */
>> +static const char * const rproc_coredump_str[] = {
>> +	[COREDUMP_DEFAULT]	= "default",
>> +	[COREDUMP_INLINE]	= "inline",
>> +	[COREDUMP_DISABLED]	= "disabled",
>> +};
>> +
>> +/* Expose the current coredump configuration via sysfs */
>> +static ssize_t coredump_show(struct device *dev, struct 
>> device_attribute
>> *attr,
>> +			      char *buf)
>> +{
>> +	struct rproc *rproc = to_rproc(dev);
>> +
>> +	return sprintf(buf, "%s\n", rproc_coredump_str[rproc-
>> >coredump_conf]);
>> +}
>> +
>> +/* Change the coredump configuration via sysfs */
>> +static ssize_t coredump_store(struct device *dev, struct 
>> device_attribute
>> *attr,
>> +			       const char *buf, size_t count)
>> +{
>> +	struct rproc *rproc = to_rproc(dev);
>> +	int err;
>> +
>> +	err = mutex_lock_interruptible(&rproc->lock);
>> +	if (err) {
>> +		dev_err(dev, "can't lock rproc %s: %d\n", rproc->name, err);
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (rproc->state == RPROC_CRASHED) {
>> +		dev_err(dev, "can't change coredump configuration\n");
>> +		err = -EBUSY;
>> +		goto out;
>> +	}
>> +
>> +	if (sysfs_streq(buf, "disable"))
>> +		rproc->coredump_conf = COREDUMP_DISABLED;
>> +	else if (sysfs_streq(buf, "inline"))
>> +		rproc->coredump_conf = COREDUMP_INLINE;
>> +	else if (sysfs_streq(buf, "default"))
>> +		rproc->coredump_conf = COREDUMP_DEFAULT;
>> +	else {
>> +		dev_err(dev, "Invalid coredump configuration\n");
>> +		err = -EINVAL;
>> +	}
>> +out:
>> +	mutex_unlock(&rproc->lock);
>> +
>> +	return err ? err : count;
>> +}
>> +static DEVICE_ATTR_RW(coredump);
>> +
>>  /* Expose the loaded / running firmware name via sysfs */
>>  static ssize_t firmware_show(struct device *dev, struct 
>> device_attribute
>> *attr,
>>  			  char *buf)
>> @@ -127,6 +183,7 @@ static ssize_t name_show(struct device *dev, 
>> struct
>> device_attribute *attr,
>>  	&dev_attr_firmware.attr,
>>  	&dev_attr_state.attr,
>>  	&dev_attr_name.attr,
>> +	&dev_attr_coredump.attr,
>>  	NULL
>>  };
>> 
>> --
>> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
>> Forum,
>> a Linux Foundation Collaborative Project

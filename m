Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69AE8C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 10:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30E852076D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 10:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584527441;
	bh=/cPJrKlaajGGqIzhjwhJr72cHDtvetySQiq4otDw5ik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=S+o0W7DSwdU46N9cyHwUEyrxeBzMaNaFVNsGxDFyqljFDbLdSRDo8sfxiiK8GDMKO
	 1tq1sMcbs1G61R1A87iikqCAtiau+KQ1Nx16Dg32L28+Gv1TzYUD0JuaIrS+099bU9
	 xDebhgsdKrMGqSNComnZaMa5kTWlKa3SpD8ElTns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbgCRKak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 06:30:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:34436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbgCRKaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 06:30:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61C3B2076C;
        Wed, 18 Mar 2020 10:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584527438;
        bh=/cPJrKlaajGGqIzhjwhJr72cHDtvetySQiq4otDw5ik=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nd+qyIkkhWzh2wnZik/yHMqgaEm2msvE4kjolKbkpKuxRzUYQ38e+mfVUoeETvkcq
         DzORZtOeWMvtcQ+FmCHIHrvx0QfJqfEAw9tQmG7lJnIAKOpHqnRbpXGsKV+b0fLhHc
         t4SILl4A7uvruZI5DQca8tfSaL05WLz3LnMwHiDw=
Date:   Wed, 18 Mar 2020 11:30:36 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [GIT PULL 3/6] intel_th: msu: Make stopping the trace optional
Message-ID: <20200318103036.GA2183221@kroah.com>
References: <20200317062215.15598-1-alexander.shishkin@linux.intel.com>
 <20200317062215.15598-4-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317062215.15598-4-alexander.shishkin@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 08:22:12AM +0200, Alexander Shishkin wrote:
> Some use cases prefer to keep collecting the trace data into the last
> available window while the other windows are being offloaded instead of
> stopping the trace. In this scenario, the window switch happens
> automatically when the next window becomes available again.
> 
> Add an option to allow this and a sysfs attribute to enable it.
> 
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  .../testing/sysfs-bus-intel_th-devices-msc    |  8 ++++
>  drivers/hwtracing/intel_th/msu.c              | 37 ++++++++++++++++++-
>  2 files changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-intel_th-devices-msc b/Documentation/ABI/testing/sysfs-bus-intel_th-devices-msc
> index 456cb62b384c..7fd2601c2831 100644
> --- a/Documentation/ABI/testing/sysfs-bus-intel_th-devices-msc
> +++ b/Documentation/ABI/testing/sysfs-bus-intel_th-devices-msc
> @@ -40,3 +40,11 @@ Description:	(RW) Trigger window switch for the MSC's buffer, in
>  		triggering a window switch for the buffer. Returns an error in any
>  		other operating mode or attempts to write something other than "1".
>  
> +What:		/sys/bus/intel_th/devices/<intel_th_id>-msc<msc-id>/stop_on_full
> +Date:		March 2020
> +KernelVersion:	5.7
> +Contact:	Alexander Shishkin <alexander.shishkin@linux.intel.com>
> +Description:	(RW) Configure whether trace stops when the last available window
> +		becomes full (1/y/Y) or wraps around and continues until the next
> +		window becomes available again (0/n/N).
> +
> diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
> index 6e118b790d83..45916b48bcf0 100644
> --- a/drivers/hwtracing/intel_th/msu.c
> +++ b/drivers/hwtracing/intel_th/msu.c
> @@ -138,6 +138,7 @@ struct msc {
>  	struct list_head	win_list;
>  	struct sg_table		single_sgt;
>  	struct msc_window	*cur_win;
> +	struct msc_window	*switch_on_unlock;
>  	unsigned long		nr_pages;
>  	unsigned long		single_sz;
>  	unsigned int		single_wrap : 1;
> @@ -154,6 +155,8 @@ struct msc {
>  
>  	struct list_head	iter_list;
>  
> +	bool			stop_on_full;
> +
>  	/* config */
>  	unsigned int		enabled : 1,
>  				wrap	: 1,
> @@ -1717,6 +1720,10 @@ void intel_th_msc_window_unlock(struct device *dev, struct sg_table *sgt)
>  		return;
>  
>  	msc_win_set_lockout(win, WIN_LOCKED, WIN_READY);
> +	if (msc->switch_on_unlock == win) {
> +		msc->switch_on_unlock = NULL;
> +		msc_win_switch(msc);
> +	}
>  }
>  EXPORT_SYMBOL_GPL(intel_th_msc_window_unlock);
>  
> @@ -1757,7 +1764,11 @@ static irqreturn_t intel_th_msc_interrupt(struct intel_th_device *thdev)
>  
>  	/* next window: if READY, proceed, if LOCKED, stop the trace */
>  	if (msc_win_set_lockout(next_win, WIN_READY, WIN_INUSE)) {
> -		schedule_work(&msc->work);
> +		if (msc->stop_on_full)
> +			schedule_work(&msc->work);
> +		else
> +			msc->switch_on_unlock = next_win;
> +
>  		return IRQ_HANDLED;
>  	}
>  
> @@ -2050,11 +2061,35 @@ win_switch_store(struct device *dev, struct device_attribute *attr,
>  
>  static DEVICE_ATTR_WO(win_switch);
>  
> +static ssize_t stop_on_full_show(struct device *dev,
> +				 struct device_attribute *attr, char *buf)
> +{
> +	struct msc *msc = dev_get_drvdata(dev);
> +
> +	return scnprintf(buf, PAGE_SIZE, "%d\n", msc->stop_on_full);

No need for the scnprinf() crazyness for a single boolean value.  Just
use sprintf() and keep it simple.

> +static ssize_t stop_on_full_store(struct device *dev,
> +				  struct device_attribute *attr,
> +				  const char *buf, size_t size)
> +{
> +	struct msc *msc = dev_get_drvdata(dev);
> +	unsigned long val;
> +	int ret;
> +
> +	ret = kstrtobool(buf, &msc->stop_on_full);
> +
> +	return ret ? ret : size;
> +}

Here's the problem, you don't use val.

And spell out the ? : crazyness:
	if (ret)
		return ret;
	return size;

much simpler for people to read and understand.

thanks,

greg k-h

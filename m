Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D749EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6AD522522
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 08:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YxB/bbIr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgAUIIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 03:08:44 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:56802 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgAUIIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 03:08:44 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00L88bcl012886;
        Tue, 21 Jan 2020 08:08:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=JokcTFeEjvvq9Vxxb4wYvQgUwTXVTIvxWBKr0alh1Jc=;
 b=YxB/bbIrZAJGeDGXg+zMWRsC40uHGOzqMvZVCRwlBNsCG1ixv2mFPW+h1xjHN3+Ib+x9
 3FiELGyRhB4zAfSqmu88OxOqPTu3pzd8PkGUOOesvjwwaBpPDSxLxUxLTlm8IjlAD0hZ
 SJmQfsdOqcM+czuehY6jeCvdCkXZlCTn/14u9tXri0LfPZCirOPrkItt/IFbkr43fhbs
 m7YbR4KUqFj9ggIY5wr1gh5lyeEjn4YB1wwATuf5iZmi43ZrRHpzh5RrtszYUrLrGi4k
 G3eRXvenJcJCcmEfszq7SmuNSuRthRQ5HMFlfLe6hUR9bc9rBOakjwJF71U1kMvmpCUN TA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2xksyq36ef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jan 2020 08:08:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00L88Fqo074370;
        Tue, 21 Jan 2020 08:08:37 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2xnpfnhqpf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Jan 2020 08:08:37 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 00L88aYj018372;
        Tue, 21 Jan 2020 08:08:36 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 Jan 2020 00:08:35 -0800
Date:   Tue, 21 Jan 2020 11:13:06 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Vladimir Stankovic <vladimir.stankovic@displaylink.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        Petar Kovacevic <petar.kovacevic@displaylink.com>,
        Nikola Simic <nikola.simic@displaylink.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marko Miljkovic <marko.miljkovic@displaylink.com>,
        Stefan Lugonjic <stefan.lugonjic@displaylink.com>
Subject: Re: staging: Add MA USB Host driver
Message-ID: <20200121081306.GG21151@kadam>
References: <VI1PR10MB19659B32E563620B4D63AF1A91320@VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM>
 <VI1PR10MB1965A077526FE296608D5B1191320@VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM>
 <VI1PR10MB19658F2B6FDAD88FAA05546591320@VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR10MB19658F2B6FDAD88FAA05546591320@VI1PR10MB1965.EURPRD10.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9506 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001210069
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9506 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001210069
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2020 at 09:30:43AM +0000, Vladimir Stankovic wrote:
> +int mausb_enqueue_event_from_user(uint8_t madev_addr, uint32_t all_events)
> +{
> +	unsigned long flags;
> +	uint16_t num_of_completed,
> +		 num_of_events;
> +	struct mausb_device *dev;
> +
> +	spin_lock_irqsave(&mss.lock, flags);
> +	dev = mausb_get_dev_from_addr_unsafe(madev_addr);
> +
> +	if (!dev) {
> +		spin_unlock_irqrestore(&mss.lock, flags);
> +		return 0;
> +	}
> +
> +	spin_lock_irqsave(&dev->num_of_user_events_lock, flags);
> +	num_of_completed = (uint16_t)all_events +
> +			   (uint16_t)dev->num_of_user_events;
> +	num_of_events	 = (all_events >> (8 * sizeof(num_of_events))) +
> +		(dev->num_of_user_events >> (8 * sizeof(num_of_events)));
> +	dev->num_of_user_events  = num_of_completed;
> +	dev->num_of_user_events |= (uint32_t)num_of_events <<
> +		(8 * sizeof(num_of_events));

I might be missing something.  Why can't we just declare two struct
members instead of doing these bit shifts to fit two values into
dev->num_of_user_events?

> +	spin_unlock_irqrestore(&dev->num_of_user_events_lock, flags);
> +	queue_work(dev->workq, &dev->work);
> +	spin_unlock_irqrestore(&mss.lock, flags);
> +
> +	return 0;
> +}

regards,
dan carpenter

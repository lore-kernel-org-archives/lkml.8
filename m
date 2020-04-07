Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 332F1C2BA2B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E812072A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="A9mKTYyT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbgDGO3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:29:54 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:57204 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbgDGO3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 10:29:53 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 037ERrKI044811;
        Tue, 7 Apr 2020 14:29:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=HiRrpXqOGpPEhIoXrzLkM1lz3EDgdVSYb4HNgvZ6e7E=;
 b=A9mKTYyTMKrKhiOLQLMQyOzxxb8sDGO+aPfIqRm90bnkqni9QZF4hwZ5osAOaUEWqWb7
 Zl2hciTiwY04I7Pl3OPgoY+tn9Fq3kAO2qX+mzWiyi0+p+mTKkBBDTye9wKlT8LIbh8s
 iIf2OagieWp/f+o44XcvBhf5leITmyzkj/0JOlWVSSVnHIEgCnjlqDOGOfhnNvC3Q7/o
 tBmfaMZ6HL8XhQXAFvPQw7i4fr4wHyZ/BEoPffQwizeUgDXMBw1XdJasiB0RxPtkzaXy
 huEwe0ztZkdIJYVhequnk1bk4ksO4fkLTtF2L6SgSGWUbA5JxtoI3jGdK3K7hdVaad4p vw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 308ffdbbqu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Apr 2020 14:29:47 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 037ERTMx033631;
        Tue, 7 Apr 2020 14:29:47 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 30741eeefj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Apr 2020 14:29:47 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 037ETieI011271;
        Tue, 7 Apr 2020 14:29:44 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Apr 2020 07:29:43 -0700
Date:   Tue, 7 Apr 2020 17:29:36 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Felipe Balbi <balbi@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v2] usb: raw-gadget: fix raw_event_queue_fetch locking
Message-ID: <20200407142936.GL2066@kadam>
References: <c4cedb13ee6159857ed7d9884e55718e4b1dede4.1586268809.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4cedb13ee6159857ed7d9884e55718e4b1dede4.1586268809.git.andreyknvl@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9583 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0
 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=699
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004070126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9583 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 mlxlogscore=750 lowpriorityscore=0
 clxscore=1011 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004070126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 04:14:50PM +0200, Andrey Konovalov wrote:
> @@ -89,11 +90,18 @@ static struct usb_raw_event *raw_event_queue_fetch(
>  	 * there's at least one event queued by decrementing the semaphore,
>  	 * and then take the lock to protect queue struct fields.
>  	 */
> -	if (down_interruptible(&queue->sema))
> -		return NULL;
> +	ret = down_interruptible(&queue->sema);
> +	if (ret)
> +		return ERR_PTR(ret);
>  	spin_lock_irqsave(&queue->lock, flags);
> -	if (WARN_ON(!queue->size))
> +	/*
> +	 * queue->size must have the same value as queue->sema counter (before
> +	 * the down_interruptible() call above), so this check is a fail-safe.
> +	 */
> +	if (WARN_ON(!queue->size)) {
> +		spin_unlock_irqrestore(&queue->lock, flags);
>  		return NULL;

I'm sorry for not noticing this earlier.  When a function returns both
error pointers and NULL then NULL is supposed to a special case of
success.  For example:

	my_struct_pointer = get_optional_feature();

If there is a memory allocation failure then my_struct_pointer is
-ENOMEM and we fail.  But say the optional feature is disabled, then
we can't return a valid pointer, but it's also working as designed so
it's not an error.  In that case we return NULL.  The surrounding code
should be written to allow NULL pointers.

So I don't think returning NULL here is correct.

regards,
dan carpenter


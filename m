Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D78BC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1200E24692
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QahxBK8b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgCJLZC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 07:25:02 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46218 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgCJLZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:25:01 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02ABO9Du003803;
        Tue, 10 Mar 2020 11:24:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=fQ47Eu6kv63WdOsfFkfD5O2wiNedBjV0+Jjt76jl4nw=;
 b=QahxBK8b4d96OJIVK5bXGrWRybNqnbedybE4eKpzP2SqfrQOVlzp4h0kKK7M8lE3QUal
 5nua7dHBvovux6eThwmdYfkAJggFY8N3Z//qwbFq60Ta5ToX73D+WjLNRX1lzWk5OQ6g
 ITi2MDyciQ8yQB/BHhqJbDX5U4tlKFJw5W01n6+Dhn/EYFPvok3lPTs8MzLeDxQXYSCo
 NuxAhZoiVvLWbeHgUNx8PUhXlCgw2xoOlP1393JbiHWAn/wv2EMqGiK0wLkf/9v2NDXM
 qi8ezEGrtbOp+59gpMDhcyHiSFZ0nzF1BxBbLZymc36uzsVu03wFia31ilzlnmUf3g1+ Jw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2yp7hm1a6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Mar 2020 11:24:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02ABHLHV024906;
        Tue, 10 Mar 2020 11:21:20 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2yp8rhgahr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Mar 2020 11:21:20 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02ABLHoo010929;
        Tue, 10 Mar 2020 11:21:17 GMT
Received: from [192.168.8.5] (/213.41.92.70)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Mar 2020 04:21:17 -0700
Subject: Re: [patch part-II V2 08/13] tracing: Provide lockdep less
 trace_hardirqs_on/off() variants
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Frederic Weisbecker <frederic@kernel.org>
References: <20200308222359.370649591@linutronix.de>
 <20200308222609.731890049@linutronix.de>
 <07a50582-1c2f-7f45-c7dd-5ff9c2ff3052@oracle.com>
 <20200310110802.GC29372@zn.tnic>
From:   Alexandre Chartre <alexandre.chartre@oracle.com>
Organization: Oracle Corporation
Message-ID: <61deae1b-cd02-ec46-06a8-ef6edd85e06f@oracle.com>
Date:   Tue, 10 Mar 2020 12:21:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20200310110802.GC29372@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=941 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100075
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 impostorscore=0
 mlxlogscore=996 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100076
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/10/20 12:08 PM, Borislav Petkov wrote:
> On Tue, Mar 10, 2020 at 11:55:57AM +0100, Alexandre Chartre wrote:
>> Shouldn't trace_hardirqs_on() be updated to call __trace_hardirqs_on()? It's the same
>> code except for the lockdep call.
> 
> Fell into that one too initially. Look again. :)
> 

Got it, rcuidle :) So maybe a better function name or a comment could avoid
this confusion.

Anyway, Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>

alex.

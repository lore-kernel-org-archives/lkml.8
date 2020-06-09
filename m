Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7556BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 16:31:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F5E620774
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 16:31:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DlBUsRRr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbgFIQbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 12:31:25 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:48276 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgFIQbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 12:31:25 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 059GQuVr029832;
        Tue, 9 Jun 2020 16:30:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=tdyLlF57UFxSaMwWDT82g2GaZb0lkNJM3qwopX+fXmQ=;
 b=DlBUsRRrZ/j92bP4SIW4e10Tmd0Zle90gGR1hWqJXWp+o4IJMB4ZBQNgr4wzHNud9/I2
 CakYvf1N+V8/SVWzz9m9tAFB1AxP4hANptQIkTmn7vxEBs5qWHOhUU4p7eRImwceOFmk
 wCRcJxAjJ4rNnKnS2wfPNCAD+Wy743awQLH+RCJDNV9oqS5FvVUEqC1UkxPrXMXt/kxW
 2yCtHwUiL1gcZ64HHKVFyPu3m7138e50hARb6az6WjI2WCXDAQdeFqo1SyDltwb1TMWh
 BAOeCWeunh5xT4cAkWyD7I+N9/kiO6ADVfqi4Y4aLCzjAvhbdLjKHB88GkMaq9SGlNZy ZA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 31g3smwraq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 09 Jun 2020 16:30:52 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 059GSNSv142368;
        Tue, 9 Jun 2020 16:30:52 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 31gn26990p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Jun 2020 16:30:51 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 059GUovU006554;
        Tue, 9 Jun 2020 16:30:50 GMT
Received: from dhcp-10-159-155-165.vpn.oracle.com (/10.159.155.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 09 Jun 2020 09:30:50 -0700
Subject: Re: [PATCH] sample-trace-array: Remove trace_array 'sample-instance'
To:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
References: <20200609135200.2206726-1-wangkefeng.wang@huawei.com>
From:   Divya Indi <divya.indi@oracle.com>
Message-ID: <cd3f1c60-ae0f-8932-7096-95da5f6d419e@oracle.com>
Date:   Tue, 9 Jun 2020 09:30:49 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200609135200.2206726-1-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9647 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=3 mlxscore=0
 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006090125
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9647 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 cotscore=-2147483648 suspectscore=3
 spamscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2006090125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Divya Indi <divya.indi@oracle.com>

On 6/9/20 6:52 AM, Kefeng Wang wrote:
> Remove trace_array 'sample-instance' if kthread_run fails
> in sample_trace_array_init().
>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  samples/ftrace/sample-trace-array.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/samples/ftrace/sample-trace-array.c b/samples/ftrace/sample-trace-array.c
> index 9e437f930280..6aba02a31c96 100644
> --- a/samples/ftrace/sample-trace-array.c
> +++ b/samples/ftrace/sample-trace-array.c
> @@ -115,8 +115,12 @@ static int __init sample_trace_array_init(void)
>  	trace_printk_init_buffers();
>  
>  	simple_tsk = kthread_run(simple_thread, NULL, "sample-instance");
> -	if (IS_ERR(simple_tsk))
> +	if (IS_ERR(simple_tsk)) {
> +		trace_array_put(tr);
> +		trace_array_destroy(tr);
>  		return -1;
> +	}
> +
>  	return 0;
>  }
>  

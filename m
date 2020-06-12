Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7342EC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 17:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 540AD20835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 17:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dLaoF70H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgFLRny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 13:43:54 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49880 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgFLRnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 13:43:53 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05CHh9hb020476;
        Fri, 12 Jun 2020 17:43:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=sDXzqeSxZKG8oEBI8F3mco5PsGVz1ZSzi3GmCkClRpM=;
 b=dLaoF70Ho+GVFZ+vOzknqvVG7qIkq9hVDWyW9ONL3/v5dj3g3fENcu4GYiCbGw1vUpKH
 t2swAKm2sSFIPp2WiVj2hzLY092JfOMMw+odVzo5mUga+aoYThxeIpAYhYFgc81i0DTZ
 6qcNMH1k2Peu8NmEetS8w8yWaoEgQtk/OtcDe+hy3EtqPMDvVXViI4FOQZGqpGI2/IDC
 tzfzVFqDAhfHsf8w8PsWktkSu08S/IUrdx6Xow9G+e5W+imuYIa6Xayf4sHQ80/6cpL/
 HtRKoOPWb7Q/TPaX/5MiSYS/lqRn+atHx+We53N3nT2RRG6onwl9n7felGhcUjSMebF3 oA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 31jepp7xvg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 12 Jun 2020 17:43:35 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05CHgkrC132293;
        Fri, 12 Jun 2020 17:43:34 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 31mebng8pe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jun 2020 17:43:34 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05CHcjqF028407;
        Fri, 12 Jun 2020 17:38:46 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 12 Jun 2020 10:38:45 -0700
Date:   Fri, 12 Jun 2020 20:38:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Walter Harms <wharms@bfs.de>
Cc:     Mike Leach <mike.leach@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] coresight: cti: Fix error handling in probe
Message-ID: <20200612173838.GH4282@kadam>
References: <20200612121047.GF4282@kadam>
 <20200612121133.GA1139533@mwanda>
 <6c59bdbc15714b089d256ad50aee58cb@bfs.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c59bdbc15714b089d256ad50aee58cb@bfs.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9650 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006120128
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9650 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 cotscore=-2147483648 adultscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006120128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 02:11:16PM +0000, Walter Harms wrote:
> Hi Dan,
> 
> nit picking in cti_pm_release()
> 
> IMHO this should be done in 2 steps:
>       if (--nr_cti_cpu == 0)
> ->
>   --nr_cti_cpu ;
>  if ( nr_cti_cpu == 0)

The first way is sort of the more canonical way to write it...  By far.

regards,
carpenter


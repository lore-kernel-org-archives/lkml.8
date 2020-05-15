Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED07DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD20A20758
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:34:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OuObXm34"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgEONes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 09:34:48 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:42616 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgEONes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 09:34:48 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04FDHCaw189812;
        Fri, 15 May 2020 13:34:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=bvCOtrlT3KuGFoRo5xNHnOKzuN1WQn5Zi9f9eT0ob+Y=;
 b=OuObXm34KPeWvimMtlSeVVJ0BzpcvIzJ6513QjvVtZDrwFJ4R3umpZmzVneeJ6jHldSJ
 Vetnu8gIjOES7FAmvCR87Ue1O4pnBPP+xs8OYEDFnV9lOk73DK09N2BhVmtkhTjk1sC4
 PiiTo/TYU38xQYyKPIM/9CXZJGyPYwcuo/f52aWwF4Ql1/e6fhP1mTcGCFHdpKdaqOFz
 rXetWniIg2tda9VdcXidJak/BdIpE8wv2oYKVbQy5JtHqiZHoixOfXKI5TN7L1mAW/6p
 9vK18QbBwKxSB08SBvev0u30pX80Wqzp6XQ0HXxBK3JvT6rKIxJF87Otm5epajcl1JkF Zg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 311nu5kgh2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 May 2020 13:34:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04FDI9qR059636;
        Fri, 15 May 2020 13:32:33 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 3100yk1rmx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 May 2020 13:32:33 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04FDWVJW030293;
        Fri, 15 May 2020 13:32:31 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 May 2020 06:32:30 -0700
Date:   Fri, 15 May 2020 16:32:24 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     John Oldman <john.oldman@polehill.co.uk>
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        kai.heng.feng@canonical.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: rtl8723bs: os_de: if-else coding style issues
Message-ID: <20200515133224.GE2078@kadam>
References: <20200515124930.3406-1-john.oldman@polehill.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515124930.3406-1-john.oldman@polehill.co.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9621 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 suspectscore=0 adultscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005150116
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9621 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 mlxlogscore=999 impostorscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 cotscore=-2147483648
 bulkscore=0 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005150116
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 01:49:30PM +0100, John Oldman wrote:
> @@ -1167,9 +1166,8 @@ void rtw_dev_unload(struct adapter *padapter)
>  			DBG_871X_LEVEL(_drv_always_, "%s: driver in IPS-FWLPS\n", __func__);
>  			pdbgpriv->dbg_dev_unload_inIPS_cnt++;
>  			LeaveAllPowerSaveMode(padapter);
> -		} else {
> +		} else
>  			DBG_871X_LEVEL(_drv_always_, "%s: driver not in IPS\n", __func__);
> -		}

You didn't run checkpatch on this patch.  The rule is that if one side
of the if else statement has curly braces then all sides get curly
braces even if they're just one line long.

regards,
dan carpenter


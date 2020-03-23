Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C31C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 13:39:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02E942076A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 13:39:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J0pPqTUx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgCWNjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 09:39:43 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60304 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728445AbgCWNjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 09:39:43 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02NDd3DW046802;
        Mon, 23 Mar 2020 13:39:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=B6xbo+X/W6byPkLPB8gr8u9US63A3zZRiGNQn2Uu/x8=;
 b=J0pPqTUx6IWbzNSK6u5Y4GqggULLph8AOavUaFMxu2gakwglKsBdrBDlwi5PEwoxbTSO
 VYb/n21qrkYKwWB37KpO/3VQ+BhZDJhX+uC96AaPXIXdRS0vSVc/4FqfZ8rsYQlGKwoF
 hn1g/fMWEQ/7so1044GZVT3MNtse4FcGF4Q1atu5PspCvKjaaXWjoNgCA9K/apYhUn7H
 juhle/qUwsfVTMoVHyVXkAgn2hTTeuDC+Sb5BOmalkbm43j/r9Cp3L40LdOkgRM+XjGZ
 A0nAQj6xa1vZsDtsI/9jjSOXseqGFVC13/uRepeVLCht1iTD6qsE0XwtfjVKz96qzsGn tA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2ywavkxjvy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Mar 2020 13:39:35 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02NDXI7S180921;
        Mon, 23 Mar 2020 13:39:34 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2yxw6jk9py-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 23 Mar 2020 13:39:34 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02NDdTwK007738;
        Mon, 23 Mar 2020 13:39:29 GMT
Received: from [10.39.222.158] (/10.39.222.158)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 23 Mar 2020 06:39:29 -0700
Subject: Re: [Xen-devel] [PATCH v3 1/2] xen: Use evtchn_type_t as a type for
 event channels
To:     Yan Yankovskyi <yyankovskyi@gmail.com>,
        Jan Beulich <jbeulich@suse.com>
Cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <20200323053325.GA15004@kbp1-lhp-F74019>
From:   Boris Ostrovsky <boris.ostrovsky@oracle.com>
Message-ID: <0d9d07e1-a828-28f2-b6ec-9d4d5bdc14be@oracle.com>
Date:   Mon, 23 Mar 2020 09:39:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200323053325.GA15004@kbp1-lhp-F74019>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9568 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003230078
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9568 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003230078
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/23/20 1:33 AM, Yan Yankovskyi wrote:
> Make event channel functions pass event channel port using
> evtchn_port_t type. It eliminates signed <-> unsigned conversion.
>
> Signed-off-by: Yan Yankovskyi <yyankovskyi@gmail.com>


Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>



> =20
> @@ -1275,7 +1276,7 @@ void rebind_evtchn_irq(int evtchn, int irq)
> =20
>  	mutex_unlock(&irq_mapping_update_lock);
> =20
> -        bind_evtchn_to_cpu(evtchn, info->cpu);
> +	bind_evtchn_to_cpu(evtchn, info->cpu);


I'd leave this as is.




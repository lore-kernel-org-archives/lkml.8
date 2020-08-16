Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A244C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 18:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7186B20674
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 18:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TWFbkiST"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbgHPSrj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 14:47:39 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34638 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgHPSrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 14:47:37 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07GIktKk178315;
        Sun, 16 Aug 2020 18:46:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=OSP019LLVSm4qpZ+oDQNzfUsCIMZ8bDvPVUwwCDMZfM=;
 b=TWFbkiST0Z1+gWj5CsncZjF5rK1MZ01QWTYACP9BmaAAObpaM8AFJ9E2kmSUx3Bvzct9
 xvjxqEJhjGGnh0b/WW+aenG52iyL1xOuKSo6dpKz61wOTHX6xtgyHajUneui4PnaxN3A
 276po80cZjnBpUsEusu0z2xEUMvE+TF7E1FGo+DG2yoasVLOkoSQg7lB8BVRZvC/C7Le
 M9iJ7caIQgsPwBjtJ3AOpKS3s1wPS57X79bePg/VRhl/PrSqLiM5+pTVw/uigxsmDwPq
 kpKISdoiv6JELqtg0xrz2oDFiBy6sX6yINjZZC8nO4OxvTsBXQNUEjiYPRvjJUyEmyjy Ww== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 32x8bmudnj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 16 Aug 2020 18:46:55 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07GIi850106094;
        Sun, 16 Aug 2020 18:44:54 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 32xs9k04r9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 16 Aug 2020 18:44:54 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07GIirET009374;
        Sun, 16 Aug 2020 18:44:53 GMT
Received: from [10.74.109.130] (/10.74.109.130)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 16 Aug 2020 11:44:53 -0700
Subject: Re: [PATCH v4 5/6] x86/paravirt: remove set_pte_at pv-op
To:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        x86@kernel.org, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     Deep Shah <sdeep@vmware.com>,
        "VMware, Inc." <pv-drivers@vmware.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
References: <20200815100641.26362-1-jgross@suse.com>
 <20200815100641.26362-6-jgross@suse.com>
From:   boris.ostrovsky@oracle.com
Organization: Oracle Corporation
Message-ID: <b564a292-a3d6-90fb-0796-cd695ff4ec67@oracle.com>
Date:   Sun, 16 Aug 2020 14:44:49 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200815100641.26362-6-jgross@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9715 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008160154
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9715 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 clxscore=1011 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008160155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/15/20 6:06 AM, Juergen Gross wrote:
> On x86 set_pte_at() is now always falling back to set_pte(). So instead
> of having this fallback after the paravirt maze just drop the
> set_pte_at paravirt operation and let set_pte_at() use the set_pte()
> function directly.
>
> Signed-off-by: Juergen Gross <jgross@suse.com>


Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>


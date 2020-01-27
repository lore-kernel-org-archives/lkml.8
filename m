Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057D3C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 06:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD6C42071E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 06:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Mhroejlr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727673AbgA0Gnn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 01:43:43 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:54194 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgA0Gnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 01:43:42 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00R6hEek178135;
        Mon, 27 Jan 2020 06:43:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2019-08-05;
 bh=vMrJ91GMO1CD+aMStdBznA5LKGeM9s5PCFnZKiLM6Zg=;
 b=MhroejlrkNIdtbIljVPw48Nka8wHrP2QJ09hldcb801d86I4e7O1TnDb/zx8cWcwF+4Y
 7aice71dKEwOa9SXGFjP5suwwh4smAfH51Bn0QTcja3BVk0t1g5PndBSCvaNNCWEWeN5
 rxAcOHxGvGXZX39QdT8pWx3QtjguzGIEtySLaKIlB6hHOMepigQPorYeuaKfoNVzo1Ch
 4DFA0USJKORo8jJSQkbSiiNPYI8z/sMcpT37ihqFdsMzHi5VYDCyGx083EynRCA0m2rw
 eH3D7qYJ+iQ3lesNFj1pNzsdd1qo4LzDheFTEe9iHPpLlG2d2VoUmYS4h8ew/K0jkVjn hg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2xrd3twe5a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jan 2020 06:43:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00R6hVuu039799;
        Mon, 27 Jan 2020 06:43:36 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2xryu8qh09-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jan 2020 06:43:36 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00R6gsKO003420;
        Mon, 27 Jan 2020 06:42:54 GMT
Received: from kadam (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 26 Jan 2020 22:42:54 -0800
Date:   Mon, 27 Jan 2020 09:42:46 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Tetsuhiro Kohada <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
Cc:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        Mori.Takahiro@ab.MitsubishiElectric.co.jp,
        motai.hirotaka@aj.mitsubishielectric.co.jp
Subject: Re: [PATCH v3] staging: exfat: remove fs_func struct.
Message-ID: <20200127064246.GO1847@kadam>
References: <20200123102445.123033-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123102445.123033-1-Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9512 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=980
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001270057
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9512 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001270057
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good to me.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter


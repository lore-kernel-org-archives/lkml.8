Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD7DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 12:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E07B206C3
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 12:54:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rt+O0AOt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730438AbgEVMyQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 08:54:16 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:53608 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbgEVMyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 08:54:10 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04MCpsF6078482;
        Fri, 22 May 2020 12:54:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=5EEXd/s1NUgU+bskJiGkekpLD34zTuJsEN8ob6uaeE0=;
 b=Rt+O0AOth6eEFdLZYAp79MGuWb0FeAN7YI8+QEgQ4lk8Xu/ZO8vdDZaGmh6TewGZWfkA
 saH7itr1tKKvHiMNSB08r51qJ6TQ9K+iQ2M16BLjbYlqpbFvg9GmfqjfwmGDnh6Xjrp5
 ivOWdOFyQ1MYpBaaKkWG0ZHrmI6gwYyX9S+49KHC6JWcRTd+vk9j1yzSd/l38M0RuSWO
 WFtF504XSYCtq7Dup8es7S6UQ4e0Iycbzi3f1Tyve7HoDXQsCsSKdGTfWZUeGQDcgx6G
 WXZcrEs6wbaIaBPDce32OflSJ/pO5lSLy3s+h8sSaesgfA/Kuk8Li3C/8w3KaW3yXHM0 JQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 31284mdjty-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 May 2020 12:54:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04MCqYDN099390;
        Fri, 22 May 2020 12:53:59 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 314gmb3pfh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 22 May 2020 12:53:59 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04MCrvbG002429;
        Fri, 22 May 2020 12:53:57 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 22 May 2020 05:53:56 -0700
Date:   Fri, 22 May 2020 15:53:50 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Souptick Joarder <jrdr.linux@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     akpm@linux-foundation.org, jgg@ziepe.ca, dsterba@suse.com,
        arnd@arndb.de, ira.weiny@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers/virt/fsl_hypervisor: Correcting error handling
 path
Message-ID: <20200522125349.GF22511@kadam>
References: <1589401396-31210-1-git-send-email-jrdr.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589401396-31210-1-git-send-email-jrdr.linux@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9628 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 phishscore=0 mlxscore=0 spamscore=0 suspectscore=2
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005220105
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9628 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 mlxscore=0
 cotscore=-2147483648 impostorscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005220105
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 01:53:16AM +0530, Souptick Joarder wrote:
> First, when memory allocation for sg_list_unaligned failed, there
> is no point of calling put_pages() as we haven't pinned any pages.
> 
> Second, if get_user_pages_fast() failed we should unpinned num_pinned
> pages, no point of checking till num_pages.
> 
> This will address both.
> 
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

If gup_flags were | FOLL_LONGTERM then this patch would fix a double
free because of the put_page() in __gup_longterm_locked().

mm/gup.c
  1786                  if (check_dax_vmas(vmas_tmp, rc)) {
  1787                          for (i = 0; i < rc; i++)
  1788                                  put_page(pages[i]);
                                        ^^^^^^^^^^^^^^^^^^^
put_page() here and also in the caller.

  1789                          rc = -EOPNOTSUPP;
  1790                          goto out;
  1791                  }

But since this isn't FOLL_LONGTERM the patch is a nice cleanup which
doesn't affect run time.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>

regards,
dan carpenter


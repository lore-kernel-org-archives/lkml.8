Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D65BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7591C20772
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="u893gaEW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgFAJ6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:58:51 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36384 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725838AbgFAJ6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:58:51 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0519v5qo042967;
        Mon, 1 Jun 2020 09:58:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=+MWb0NMAavkFKneRr+1BaI52k7RdQE32+asYQPFsXs8=;
 b=u893gaEWiwlmBK8N8qW/iMWFiy9K5zfsfvTh3ZeQPvIb5CgpufH/2DtrtlbBxAX7l5Y+
 pI+WsBDxM9X3W67JQ3+qOqBh9Aqk+qlL9nfvUpMIzKGhfX+tJrvevHKia8bhl4PAG6N2
 6IenKHArPG5o8nBtOJdo8Ec8JbVsOyP0QU872/DSv3iz3ZtAd+TDH0JCEmtSmtsyYPPX
 /XDb4H1GZIl5FqW3HNqUXE4OZiUh+HUeQHY6/l9vfCrx05A5YbdXHUkGZUod805smOC/
 KBm4+OPwuPR5Ba0wX8sgZvHlXvJVfluHby2mh3dpTyK8+NzA7jW4VDQ6Sejc7q+RmrqO 0Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 31bfekwv3b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 01 Jun 2020 09:58:22 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0519lqT9033852;
        Mon, 1 Jun 2020 09:56:21 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 31c25j7x1a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 01 Jun 2020 09:56:21 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0519uElR022723;
        Mon, 1 Jun 2020 09:56:14 GMT
Received: from tomti.i.net-space.pl (/10.175.213.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 01 Jun 2020 02:56:13 -0700
Date:   Mon, 1 Jun 2020 11:56:05 +0200
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     grub-devel@gnu.org, linux-kernel@vger.kernel.org,
        trenchboot-devel@googlegroups.com, x86@kernel.org,
        xen-devel@lists.xenproject.org, alec.brown@oracle.com,
        alexander.burmashev@oracle.com, andrew.cooper3@citrix.com,
        ard.biesheuvel@linaro.org, dpsmith@apertussolutions.com,
        eric.snowberg@oracle.com, hpa@zytor.com, javierm@redhat.com,
        kanth.ghatraju@oracle.com, konrad.wilk@oracle.com,
        krystian.hebel@3mdeb.com, leif@nuviainc.com,
        lukasz.hawrylko@linux.intel.com, michal.zygowski@3mdeb.com,
        mjg59@google.com, mtottenh@akamai.com, phcoder@gmail.com,
        piotr.krol@3mdeb.com, pjones@redhat.com, ross.philipson@oracle.com
Subject: Re: [BOOTLOADER SPECIFICATION RFC] The bootloader log format for
 TrenchBoot and others
Message-ID: <20200601095605.oxhq74llusb7k6ma@tomti.i.net-space.pl>
References: <20200529112735.qln44ds6z7djheof@tomti.i.net-space.pl>
 <7FE0DF48-C221-460E-99D5-00E42128283C@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7FE0DF48-C221-460E-99D5-00E42128283C@amacapital.net>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9638 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006010072
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9638 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 phishscore=0 clxscore=1011
 impostorscore=0 adultscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006010073
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 10:11:40AM -0700, Andy Lutomirski wrote:
> > On May 29, 2020, at 4:30 AM, Daniel Kiper <daniel.kiper@oracle.com> wrote:
> >
> > Hey,
> >
> > Below you can find my rough idea of the bootloader log format which is
> > generic thing but initially will be used for TrenchBoot work. I discussed
> > this proposal with Ross and Daniel S. So, the idea went through initial
> > sanitization. Now I would like to take feedback from other folks too.
> > So, please take a look and complain...
>
> > In general we want to pass the messages produced by the bootloader to the OS
> > kernel and finally to the userspace for further processing and analysis. Below
> > is the description of the structures which will be used for this thing.
>
> Is the intent for a human to read these, or to get them into the
> system log file, or are they intended to actually change the behavior
> of the system?
>
> IOW, what is this for?

In general the idea is for a human to read these. There will be a separate
tool which reads the bootloader log exposed via Linux kernel sysfs and displays
its contents to the user. The tool will allow user to do various kinds of
filtering. We are not going to put the contents of the bootloader log into any
of system logs. However, if somebody wants to do that, in sensible way, I am
OK with that.

Daniel

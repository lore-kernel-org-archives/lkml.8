Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86408C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 11:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62BE5206C3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 11:30:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lCxs8Ju2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgE2LaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 07:30:18 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:46378 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgE2LaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 07:30:18 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04TBRqwW031292;
        Fri, 29 May 2020 11:29:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=6iJ4GznZqm2hlC858ywesGuHoOqwbI3EjIs9Cz3b8xw=;
 b=lCxs8Ju2uHpWLEkPe2LPs/Zc/PUgNbNqoNOH1xPPrYxdgN+Dqlxj78SXBlz97UIGRkS3
 sfwA4zGEz5LarLDbkUp/FU+MNB1SDgQQPet2LOmUIdQE8Hp2sqpvKwLN+S18j996ZLmm
 ykS5TUe3gq7N5OFcBdOgjyfGSW1xIPKUCKm5lDzieQJ3bsg0S/1jpzJyq7LojDr8SHDZ
 JvQlybZjNvoyKfMQm4RlorKoLDvviWwlJLje7FNdjLrie1et0wDka/p2du91XQXNYETI
 AVJ1C7AL50/tHEDVHoxy7DEVQHkSAPODUOc/m3tZYaWihL71EsPHSAPSlL/ZkgDlVUjC aQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 318xbk9wc2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 May 2020 11:29:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04TBRfFK184985;
        Fri, 29 May 2020 11:27:54 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 317j5y74m1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 May 2020 11:27:53 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04TBRhSd021678;
        Fri, 29 May 2020 11:27:43 GMT
Received: from tomti.i.net-space.pl (/10.175.161.105)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 29 May 2020 04:27:43 -0700
Date:   Fri, 29 May 2020 13:27:35 +0200
From:   Daniel Kiper <daniel.kiper@oracle.com>
To:     grub-devel@gnu.org, linux-kernel@vger.kernel.org,
        trenchboot-devel@googlegroups.com, x86@kernel.org,
        xen-devel@lists.xenproject.org
Cc:     alec.brown@oracle.com, alexander.burmashev@oracle.com,
        andrew.cooper3@citrix.com, ard.biesheuvel@linaro.org,
        dpsmith@apertussolutions.com, eric.snowberg@oracle.com,
        hpa@zytor.com, javierm@redhat.com, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, krystian.hebel@3mdeb.com,
        leif@nuviainc.com, lukasz.hawrylko@linux.intel.com,
        michal.zygowski@3mdeb.com, mjg59@google.com, mtottenh@akamai.com,
        phcoder@gmail.com, piotr.krol@3mdeb.com, pjones@redhat.com,
        ross.philipson@oracle.com
Subject: [BOOTLOADER SPECIFICATION RFC] The bootloader log format for
 TrenchBoot and others
Message-ID: <20200529112735.qln44ds6z7djheof@tomti.i.net-space.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9635 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005290092
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9635 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 cotscore=-2147483648
 suspectscore=0 bulkscore=0 clxscore=1011 impostorscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005290092
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

Below you can find my rough idea of the bootloader log format which is
generic thing but initially will be used for TrenchBoot work. I discussed
this proposal with Ross and Daniel S. So, the idea went through initial
sanitization. Now I would like to take feedback from other folks too.
So, please take a look and complain...

In general we want to pass the messages produced by the bootloader to the OS
kernel and finally to the userspace for further processing and analysis. Below
is the description of the structures which will be used for this thing.

  struct bootloader_log_msgs
  {
    grub_uint32_t level;
    grub_uint32_t facility;
    char type[];
    char msg[];
  }

  struct bootloader_log
  {
    grub_uint32_t version;
    grub_uint32_t producer;
    grub_uint32_t size;
    grub_uint32_t next_off;
    bootloader_log_msgs msgs[];
  }

The members of struct bootloader_log:
  - version: the bootloader log format version number, 1 for now,
  - producer: the producer/bootloader type; we can steal some values from
    linux/Documentation/x86/boot.rst:type_of_loader,
  - size: total size of the log buffer including the bootloader_log struct,
  - next_off: offset in bytes, from start of the bootloader_log struct,
    of the next byte after the last log message in the msgs[];
    i.e. the offset of the next available log message slot,
  - msgs: the array of log messages.

The members of struct bootloader_log_msgs:
  - level: similar to syslog meaning; can be used to differentiate
    normal messages from debug messages; exact interpretation depends
    on the current producer/bootloader type specified in the
    bootloader_log.producer,
  - facility: similar to syslog meaning; can be used to differentiate
    the sources of the messages, e.g. message produced by networking
    module; exact interpretation depends on the current producer/bootloader
    type specified in the bootloader_log.producer,
  - type: similar to the facility member but NUL terminated string instead of integer;
    this will be used by GRUB for messages printed using grub_dprintf(),
  - msg: the bootloader log message, NUL terminated string.

Note: The bootloaders are free to use/ignore any given set of level,
      facility and/or type members. Though the usage of these members
      has to be clearly defined. Ignored integer members should be set
      to 0. Ignored type member should contain an empty NUL terminated
      string. msg member is mandatory but can be an empty NUL terminated
      string.

Taking into account [1] and [2] I want to make this functionality generic
as much as possible. So, this bootloader log can be used with any bootloader
and OS kernel. However, initially the functionality will be implemented for
the Linux kernel and its boot protocol.

In case of Linux kernel the pointer to the bootloader_log struct should
be passed from the bootloader to the kernel through the boot_params and
the bootloader_log struct contents should be exposed via sysfs. E.g.
somewhere at /sys/kernel/debug or /sys/kernel/tracing or maybe we should
create new /sys/bootloader/log node.

If everybody is OK with this rough proposal then I will start working
on making it a part of Multiboot2 specification (the text above is just
raw description of the idea; it is not final text which land into the
spec). If you see better place for this thing just drop me a line.

Daniel

[1] https://lists.gnu.org/archive/html/grub-devel/2019-10/msg00107.html
[2] https://lists.gnu.org/archive/html/grub-devel/2019-11/msg00079.html

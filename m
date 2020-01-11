Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B629C33CA7
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 00:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 688F620866
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 00:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731826AbgALAtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 19:49:24 -0500
Received: from mail3-bck.iservicesmail.com ([217.130.24.85]:55685 "EHLO
        mail3-bck.iservicesmail.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731813AbgALAtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 19:49:24 -0500
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Sat, 11 Jan 2020 19:49:23 EST
IronPort-SDR: WuBgNbUOfzPZRlk0wDRH8tB4VDjVhHieTQj9F27bRadU6i4IXr+V/1yMbvLLzwJ/aWxzmhp1+F
 +5SqkYT14mog==
IronPort-PHdr: =?us-ascii?q?9a23=3A85EPcBBxNvJ9m/c2PaYFUyQJP3N1i/DPJgcQr6?=
 =?us-ascii?q?AfoPdwSPTyocbcNUDSrc9gkEXOFd2Cra4d0KyM7f6rAzBIyK3CmUhKSIZLWR?=
 =?us-ascii?q?4BhJdetC0bK+nBN3fGKuX3ZTcxBsVIWQwt1Xi6NU9IBJS2PAWK8TW94jEIBx?=
 =?us-ascii?q?rwKxd+KPjrFY7OlcS30P2594HObwlSizexfL1/IA+ooQjQt8QajpVuJ6kswR?=
 =?us-ascii?q?bVv3VEfPhby3l1LlyJhRb84cmw/J9n8ytOvv8q6tBNX6bncakmVLJUFDspPX?=
 =?us-ascii?q?w7683trhnDUBCA5mAAXWUMkxpHGBbK4RfnVZrsqCT6t+592C6HPc3qSL0/RD?=
 =?us-ascii?q?qv47t3RBLulSwLMTk1/nzLhcNqiaJaoAutqgJ4w47OeIGVM+B+cbnBfdwEXG?=
 =?us-ascii?q?ZOQMBRWzVdD4Ogc4sAFfYOPeZGoIn4uVQOqwe+CRCyC+Pp0zNGgXj23ask3O?=
 =?us-ascii?q?UhCA3JwgogFM8KvHnasNn5KKIeXOaox6fK0DrDdetb1zn95ojSbB4vouyCUr?=
 =?us-ascii?q?1sfsTe0kQvCwHIgUmMpYD5Iz+ZyOIAuHWb4ep6UuKvjnYqpRtvrTiz2MgskJ?=
 =?us-ascii?q?TCiYISylDC+iVy3YE4JcWmR05nf9GkCpVRtyacN4t5Wc4iQ3potz0mxbEcpZ?=
 =?us-ascii?q?G7ey0KxI4nxx7ccvGKdZWD7BH7VOuJPzt0mXBodKiiixu87USs0PPwW8au3F?=
 =?us-ascii?q?tEridIlMTHuGoX2BzJ8MeHT+Nw/kKm2TmSyQ/e8vpEIUUolarDLJ4h36Iwmo?=
 =?us-ascii?q?ITsUvdGi/2n137jKqMeUUl/uio8froYrH6qpKTLYN0lAb+Pbk0lcyxBuQ4NB?=
 =?us-ascii?q?YBU3KF9uSnzLHj/Ev5T6tWjvAujKXVrZLXKd4GqqO3HwNZyJgv5hmlAzqo0N?=
 =?us-ascii?q?kUhXwHI0hEeBKDgYjpIVbOIPXgAPennVusjClkx+rIP73mBJXNIWPOkLf6fb?=
 =?us-ascii?q?lm90FQ0hY8zdda555OCrEBI+r/WlXtu9zAEh85Lwu0zv7jCNV80IMeRG2ODr?=
 =?us-ascii?q?aaMKzMq1+I4PwgI+2XaY8LtzbyNeIl6+TtjXAng18de7em3Z8NZHC/BPRmLB?=
 =?us-ascii?q?bRXX25htYHDHdPvQckSuHuoEONXCQVZHuoWa84oDYhB9GcAJ/HV7yq1YSMwC?=
 =?us-ascii?q?qhVqJRYG8OXkiBDXryaIKCVPcXYimSIedulzUFUf6qTIp3hj+0swqv87d7I/?=
 =?us-ascii?q?CcxSoeutq3zNVp6vfMkhc93TxvBc/b2GaICWF3yDBbDwQq1bxy9BUugmyI1r?=
 =?us-ascii?q?J11qcATdE=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2HVAQDnahpelyMYgtlMGBoBAQEBAQE?=
 =?us-ascii?q?BAQEDAQEBAREBAQECAgEBAQGBaAQBAQEBCwEBGwQBgSmBTVIgEpNQgU0fg0O?=
 =?us-ascii?q?LY4EAgx4VhgcUDIFbDQEBAQEBNQIBAYRATgEXgQ8kNQgOAgMNAQEFAQEBAQE?=
 =?us-ascii?q?FBAEBAhABAQEBAQYYBoVzgh0MHgEEAQEBAQMDAwEBDAGDXQcZDzlKTAEOAVO?=
 =?us-ascii?q?DBIJLAQEznXABjQQNDQKFHYJJBAqBCYEaI4E2AYwYGoFBP4EjIYIrCAGCAYJ?=
 =?us-ascii?q?/ARIBbIJIglkEjUISIYEHiCmYF4JBBHaJTIwCgjcBD4gBhDEDEIJFD4EJiAO?=
 =?us-ascii?q?EToF9ozdXdAGBHnEzGoImGoEgTxgNiBuOLUCBFhACT4xbgjIBAQ?=
X-IPAS-Result: =?us-ascii?q?A2HVAQDnahpelyMYgtlMGBoBAQEBAQEBAQEDAQEBAREBA?=
 =?us-ascii?q?QECAgEBAQGBaAQBAQEBCwEBGwQBgSmBTVIgEpNQgU0fg0OLY4EAgx4VhgcUD?=
 =?us-ascii?q?IFbDQEBAQEBNQIBAYRATgEXgQ8kNQgOAgMNAQEFAQEBAQEFBAEBAhABAQEBA?=
 =?us-ascii?q?QYYBoVzgh0MHgEEAQEBAQMDAwEBDAGDXQcZDzlKTAEOAVODBIJLAQEznXABj?=
 =?us-ascii?q?QQNDQKFHYJJBAqBCYEaI4E2AYwYGoFBP4EjIYIrCAGCAYJ/ARIBbIJIglkEj?=
 =?us-ascii?q?UISIYEHiCmYF4JBBHaJTIwCgjcBD4gBhDEDEIJFD4EJiAOEToF9ozdXdAGBH?=
 =?us-ascii?q?nEzGoImGoEgTxgNiBuOLUCBFhACT4xbgjIBAQ?=
X-IronPort-AV: E=Sophos;i="5.69,423,1571695200"; 
   d="scan'208";a="323066160"
Received: from mailrel04.vodafone.es ([217.130.24.35])
  by mail02.vodafone.es with ESMTP; 12 Jan 2020 01:44:19 +0100
Received: (qmail 8341 invoked from network); 11 Jan 2020 23:46:31 -0000
Received: from unknown (HELO 192.168.1.3) (quesosbelda@[217.217.179.17])
          (envelope-sender <peterwong@hsbc.com.hk>)
          by mailrel04.vodafone.es (qmail-ldap-1.03) with SMTP
          for <linux-kernel@vger.kernel.org>; 11 Jan 2020 23:46:31 -0000
Date:   Sun, 12 Jan 2020 00:46:30 +0100 (CET)
From:   Peter Wong <peterwong@hsbc.com.hk>
Reply-To: Peter Wong <peterwonghsbchk@gmail.com>
To:     linux-kernel@vger.kernel.org
Message-ID: <25060173.172050.1578786391149.JavaMail.cash@217.130.24.55>
Subject: Investment opportunity
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,
Please read the attached investment proposal and reply for more details.
Are you interested in loan?
Sincerely: Peter Wong




----------------------------------------------------
This email was sent by the shareware version of Postman Professional.


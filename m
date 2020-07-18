Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.7 required=3.0 tests=BAYES_50,DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F976C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 17:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BC9420717
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 17:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgGQRJS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 13:09:18 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.4]:11261 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726205AbgGQRJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 13:09:17 -0400
Received: from [100.113.3.117] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-a.eu-central-1.aws.symcld.net id 91/F4-22706-B3BD11F5; Fri, 17 Jul 2020 17:09:15 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJIsWRWlGSWpSXmKPExsWi9LMqRtfytmC
  8wblzuhaXd81hc2D0+LxJLoAxijUzLym/IoE1493WJywFuRWHnyxna2CM7WLk4hASeMooMaNv
  FguEs41Rou/zc+YuRk4OZgE9iRtTp7CB2LwCghInZz5hgYhrSyxb+BqohgPIVpP42lUCEhYW4
  JG43f+CCcQWEVCS+H6tmxGkhE1AReLC6yCQMIuAqsSJ1SBhTqBVshIzN55mgpjuKrF94QJWiL
  iyRO/K9YwTGHlnITliFpIjZiE5YhbCEQsYWVYxWiYVZaZnlOQmZuboGhoY6BoaGusa6hqaGOk
  lVukm6qWW6ian5pUUJQJl9RLLi/WKK3OTc1L08lJLNjECwzClkLFvB+PENx/0DjFKcjApifK2
  rRKMF+JLyk+pzEgszogvKs1JLT7EKMPBoSTB+/8GUE6wKDU9tSItMwcYEzBpCQ4eJRHeiJtAa
  d7igsTc4sx0iNQpRnuOu0/mLmLmuAcmdxydByQfrVqyiFmIJS8/L1VKHKJNAKQtozQPbigshi
  8xykoJ8zIyMDAI8RSkFuVmlqDKv2IU52BUEuadCzKFJzOvBG73K6CzmIDO2viZF+SskkSElFQ
  Dk2jzztv+VTIf7udvPcH+Yz3Xguiz/YLZ1aeV7CMN/jLFXO5xzyx6kM0deX7bednSpcEcypdU
  mor2pF9ob1vnMSNQ/rvTLM7NvxvXfd48V6H/RqZGYECbY5aicHBcE6PclespOe/6k88pZCjIa
  VV+dXv2KFQ/cXoLb3GX+SSmI1zRDGvKODJm/vdkzNKsefvSREJ9Y5uGcTTTn+VbYk943j8Vsf
  BPw6XN774Ld3p/Y7kquVD9wbKg5o/l5jxPFgZKvL30c/rBBtmvJZv21azjF/9yM35dQPZh/yl
  yiyu0vE7FvelwV5wovGWltxiT2LqZ+gUOx3aLJ7SX+MvJcrqLLvBb9KpJ8J56b+M53xYlluKM
  REMt5qLiRABL4W73XAMAAA==
X-Env-Sender: heart@vibrantmedia.com
X-Msg-Ref: server-22.tower-232.messagelabs.com!1595005750!1126681!11
X-Originating-IP: [34.249.122.92]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.50.2; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 6480 invoked from network); 17 Jul 2020 17:09:13 -0000
Received: from mail.vibrantmedia.com (HELO mbx04.vibrant.corp) (34.249.122.92)
  by server-22.tower-232.messagelabs.com with ECDHE-RSA-AES256-SHA384 encrypted SMTP; 17 Jul 2020 17:09:13 -0000
Received: from mbx03.vibrant.corp (10.1.128.21) by mbx04.vibrant.corp
 (10.1.129.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Fri, 17
 Jul 2020 17:09:08 +0000
Received: from [213.32.33.253] (213.32.33.253) by mbx03.vibrant.corp
 (10.1.128.21) with Microsoft SMTP Server id 15.1.669.32 via Frontend
 Transport; Fri, 17 Jul 2020 17:09:07 +0000
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Description: Mail message body
Subject: REP
To:     <linux-kernel@vger.kernel.org>
From:   ANDON <heart@vibrantmedia.com>
Date:   Fri, 17 Jul 2020 18:01:26 -0700
Reply-To: <info@skilsaws.org>
Message-ID: <ee9a0266-1450-4ec9-b54b-9da787badf40@mbx03.vibrant.corp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andon is seeking a motivated Company/Person representatives on part time basis with good salary structure.

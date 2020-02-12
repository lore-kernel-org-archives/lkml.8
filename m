Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F40C3B187
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 00:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 547DF20842
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 00:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581467749;
	bh=O3iLdjra2rXeebyKBMhajToC7LRorp8lLz2ui6hj++0=;
	h=To:Cc:From:Subject:Date:List-ID:From;
	b=P7K4PBldbexhrkZzG5TToHZqlGICIlRj+e+QDHcYbW5rFU/gL/cPVQwznTu6ytI2S
	 R9VlIqa3umhwMlCSdbmBuw8p+jtuA5dvbN0bUmDz054Ho1amDXYxv6VB0nUi3D4+61
	 SAhxhIMiyc9jEPp+pORo/7UkWReK/bfoiK1ufikI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgBLAfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 19:35:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:38830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728041AbgBLAfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 19:35:48 -0500
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8257C2082F;
        Wed, 12 Feb 2020 00:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581467747;
        bh=O3iLdjra2rXeebyKBMhajToC7LRorp8lLz2ui6hj++0=;
        h=To:Cc:From:Subject:Date:From;
        b=lwD3fjeqhBDoQuf1aHwDSaPQCGgScSjoSinHwrFf26haQ94IC8L1AK1wq2W6lo64B
         rTj4K2o4bbpZ+z5HEWXQYE66a4LQNHMqsufLuZMkGwEchZyLk3UZOTAPopVeql6jsa
         pqmo6xFfLYIazxktHzIOzP4vFKsQo3hwHukTG7zI=
To:     linux-kselftest@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Safonov <dima@arista.com>,
        Aleksa Sarai <cyphar@cyphar.com>
Cc:     shuah <shuah@kernel.org>
From:   shuah <shuah@kernel.org>
Subject: Linux 5.6-rc1 kselftest build failures
Message-ID: <ff16537e-febc-1b98-0cf8-1aa23e0c29b0@kernel.org>
Date:   Tue, 11 Feb 2020 17:35:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following tests fail to build on x86_64

openat2:

tools/testing/selftests/openat2'
gcc -Wall -O2 -g -fsanitize=address -fsanitize=undefined 
openat2_test.c helpers.c  -o tools/testing/selftests/openat2/openat2_test
In file included from /usr/include/fcntl.h:301,
                  from helpers.c:9:
In function ‘openat’,
     inlined from ‘touchat’ at helpers.c:49:11:
/usr/include/x86_64-linux-gnu/bits/fcntl2.h:126:4: error: call to 
‘__openat_missing_mode’ declared with attribute error: openat with 
O_CREAT or O_TMPFILE in third argument needs 4 arguments
   126 |    __openat_missing_mode ();
       |    ^~~~~~~~~~~~~~~~~~~~~~~~

timerns:

tools/testing/selftests/timens'
gcc -Wall -Werror -pthread  -lrt -ldl  timens.c  -o 
tools/testing/selftests/timens/timens
/usr/bin/ld: /tmp/ccGy5CST.o: in function `check_config_posix_timers':
timens.c:(.text+0x65a): undefined reference to `timer_create'
collect2: error: ld returned 1 exit status

thanks,
-- Shuah

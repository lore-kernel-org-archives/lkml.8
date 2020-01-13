Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FF9C33CAE
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 08:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F3E207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 08:29:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728820AbgAMI3K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 03:29:10 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56284 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728680AbgAMI3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 03:29:10 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00D8QrUx110802
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 03:29:09 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xfvaxv6s8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 03:29:08 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <ravi.bangoria@linux.ibm.com>;
        Mon, 13 Jan 2020 08:29:06 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 13 Jan 2020 08:29:03 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00D8T2Dm56492220
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 13 Jan 2020 08:29:02 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1F0F442049;
        Mon, 13 Jan 2020 08:29:02 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 539E842041;
        Mon, 13 Jan 2020 08:29:00 +0000 (GMT)
Received: from [9.124.31.171] (unknown [9.124.31.171])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 13 Jan 2020 08:29:00 +0000 (GMT)
From:   Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: Re: [GIT PULL 0/6] perf/urgent fixes
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
References: <20191205193224.24629-1-acme@kernel.org>
Date:   Mon, 13 Jan 2020 13:58:59 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20191205193224.24629-1-acme@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20011308-4275-0000-0000-000003970CE9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20011308-4276-0000-0000-000038AB021A
Message-Id: <6489b96f-5117-f133-1c2d-63c0c1691f4b@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-13_02:2020-01-13,2020-01-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 phishscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 clxscore=1011 spamscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001130071
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/6/19 1:02 AM, Arnaldo Carvalho de Melo wrote:
>    39 fedora:31                     : Ok   gcc (GCC) 9.2.1 20190827 (Red Hat 9.2.1-1), clang version 9.0.0 (Fedora 9.0.0-1.fc31)

Not related to this pull request, but because we are discussing the
bison issue in this thread, I thought to report here.

On my Fedora 31, gtk2 also fails:

   $ rpm -qa | grep gtk2
   gtk2-2.24.32-6.fc31.x86_64
   gtk2-devel-2.24.32-6.fc31.x86_64

   $ make
   Auto-detecting system features:
   ...                         glibc: [ on  ]
   ...                          gtk2: [ OFF ]
   ...                      libaudit: [ on  ]

   Makefile.config:687: GTK2 not found, disables GTK2 support. Please install gtk2-devel or libgtk2.0-dev


Detail logs:

   $ cat tools/build/feature/test-gtk2.make.output
   In file included from /usr/include/gtk-2.0/gtk/gtkobject.h:37,
                    from /usr/include/gtk-2.0/gtk/gtkwidget.h:36,
                    from /usr/include/gtk-2.0/gtk/gtkcontainer.h:35,
                    from /usr/include/gtk-2.0/gtk/gtkbin.h:35,
                    from /usr/include/gtk-2.0/gtk/gtkwindow.h:36,
                    from /usr/include/gtk-2.0/gtk/gtkdialog.h:35,
                    from /usr/include/gtk-2.0/gtk/gtkaboutdialog.h:32,
                    from /usr/include/gtk-2.0/gtk/gtk.h:33,
                    from test-gtk2.c:3:
   /usr/include/gtk-2.0/gtk/gtktypeutils.h:236:1: error: ‘GTypeDebugFlags’ is deprecated [-Werror=deprecated-declarations]
     236 | void            gtk_type_init   (GTypeDebugFlags    debug_flags);
         | ^~~~
   In file included from /usr/include/glib-2.0/gobject/gobject.h:24,
                    from /usr/include/glib-2.0/gobject/gbinding.h:29,
                    from /usr/include/glib-2.0/glib-object.h:23,
                    from /usr/include/glib-2.0/gio/gioenums.h:28,
                    from /usr/include/glib-2.0/gio/giotypes.h:28,
                    from /usr/include/glib-2.0/gio/gio.h:26,
                    from /usr/include/gtk-2.0/gdk/gdkapplaunchcontext.h:30,
                    from /usr/include/gtk-2.0/gdk/gdk.h:32,
                    from /usr/include/gtk-2.0/gtk/gtk.h:32,
                    from test-gtk2.c:3:
   /usr/include/glib-2.0/gobject/gtype.h:679:1: note: declared here
     679 | {
         | ^
   In file included from /usr/include/gtk-2.0/gtk/gtktoolitem.h:31,
                    from /usr/include/gtk-2.0/gtk/gtktoolbutton.h:30,
                    from /usr/include/gtk-2.0/gtk/gtkmenutoolbutton.h:30,
                    from /usr/include/gtk-2.0/gtk/gtk.h:126,
                    from test-gtk2.c:3:
   /usr/include/gtk-2.0/gtk/gtktooltips.h:73:3: error: ‘GTimeVal’ is deprecated: Use 'GDateTime' instead [-Werror=deprecated-declarations]
      73 |   GTimeVal last_popdown;
         |   ^~~~~~~~
   In file included from /usr/include/glib-2.0/glib/galloca.h:32,
                    from /usr/include/glib-2.0/glib.h:30,
                    from /usr/include/glib-2.0/gobject/gbinding.h:28,
                    from /usr/include/glib-2.0/glib-object.h:23,
                    from /usr/include/glib-2.0/gio/gioenums.h:28,
                    from /usr/include/glib-2.0/gio/giotypes.h:28,
                    from /usr/include/glib-2.0/gio/gio.h:26,
                    from /usr/include/gtk-2.0/gdk/gdkapplaunchcontext.h:30,
                    from /usr/include/gtk-2.0/gdk/gdk.h:32,
                    from /usr/include/gtk-2.0/gtk/gtk.h:32,
                    from test-gtk2.c:3:
   /usr/include/glib-2.0/glib/gtypes.h:551:8: note: declared here
     551 | struct _GTimeVal
         |        ^~~~~~~~~
   cc1: all warnings being treated as errors


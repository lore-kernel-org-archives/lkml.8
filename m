Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F0CC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 20:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74B282067C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 20:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CK8l+vZo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgHXUyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 16:54:35 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:34878 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbgHXUyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 16:54:33 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07OKrujQ001381;
        Mon, 24 Aug 2020 20:53:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=c4tTQwgRXwM5ARju4FlIwJfaQb8i4m5GCIC+yda2N5w=;
 b=CK8l+vZoCA8jA222sHhZ0Au75OjAwOrDRoTPiGtlYq/KBKWS6rCy7HP9ylj0dXkUph6w
 GA7NkbnaH77pq9iQ+h9p94W6Z3oeL1Gw5x7533nzrLWLLhrBxVkIv4BhxwijYOh70pv2
 VqQ0GsqK+p4e9/qBYS6ah9jNRC1EkQjLUrCen0gybv6Vnqa42HjGjbcEjZ/Jw+KdlN+I
 Uw2U2q5uo2XWNGaXjfhAZraKFhifgOrPKFQzy4c7hL5FFyAaQB3DEYvGO0M6nkVSihKG
 eDE1JTQHn3by6DeanERTpGRwJbKRkP+OrH4uzLB6Z+I4M/tY5E5JC2tVgDKGuCYDCDvg sw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 333dbrpw8y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 24 Aug 2020 20:53:56 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07OKoYWA063700;
        Mon, 24 Aug 2020 20:53:55 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 333rtx0vpx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Aug 2020 20:53:55 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07OKroVA009900;
        Mon, 24 Aug 2020 20:53:50 GMT
Received: from [192.168.0.193] (/69.207.174.138)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Aug 2020 13:53:50 -0700
Subject: Re: [RFC] Design proposal for upstream core-scheduling interface
To:     Joel Fernandes <joel@joelfernandes.org>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        JulienDesfossez@google.com, jdesfossez@digitalocean.com,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>, vineethrp@gmail.com,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        dhaval.giani@gmail.com, paulmck@kernel.org, joshdon@google.com,
        xii@google.com, haoluo@google.com, bsegall@google.com
References: <20200822030155.GA414063@google.com>
From:   chris hyser <chris.hyser@oracle.com>
Message-ID: <6d25f0e8-9894-386e-7669-9ecbc176bd5b@oracle.com>
Date:   Mon, 24 Aug 2020 16:53:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200822030155.GA414063@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9723 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008240163
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9723 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1011
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008240163
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/20 11:01 PM, Joel Fernandes wrote:
> Hello!
> Core-scheduling aims to allow making it safe for more than 1 task that trust
> each other to safely share hyperthreads within a CPU core [1]. This results
> in a performance improvement for workloads that can benefit from using
> hyperthreading safely while limiting core-sharing when it is not safe.
> 
> Currently no universally agreed set of interface exists and companies have
> been hacking up their own interface to make use of the patches. This post
> aims to list usecases which I got after talking to various people at Google
> and Oracle. After which actual development of code to add interfaces can follow.
> 
> The below text uses the terms cookie and tag interchangeably. Further, cookie
> of 0 is assumed to indicate a trusted process - such as kernel threads or
> system daemons. By default, if nothing is tagged then everything is
> considered trusted since the scheduler assumes all tasks are a match for each
> other.
> 
> Usecase 1: Google's cloud group tags CGroups with a 32-bit integer. This
> int32 is split into 2 parts, the color and the id. The color can only be set
> by privileged processes and the id can be set by anyone. The CGroup structure
> looks like:
> 
>     A         B
>    / \      / \ \
>   C   D    E  F  G
> 
> Here A and B are container CGroups for 2 jobs are assigned a color by a
> privileged daemon. The job itself has more sub-CGroups within (for ex, B has
> E, F and G). When these sub-CGroups are spawned, they inherit the color from
> the parent. An unprivileged user can then set an id for the sub-CGroup
> without the knowledge of the privileged daemon if it desires to add further
> isolation. This setting of id can be an unprivileged operation because the
> root daemon has already isolated A and B.
> 
> Usecase 2: Chrome browser - tagging renderers. In Chrome, each tab opened
> spawns a renderer. A renderer is a sandboxed process and it is assumed it
> could run arbitrary code (Javascript etc). When a renderer is created, a
> prctl call is made to tag the renderer. Every thread that is spawned by the
> renderer is also tagged. Essentially this turns SMT off for the renderer, but
> still gives a performance boost due to privileged system threads being able
> to share a core. The tagging also forbids the renderer from sharing a core
> with privileged system processes. In the future, we plan to allow threads to
> share a core as well (especially once we get syscall-isolation upstreamed.
> Patches were posted recently for the same [2]).
> 
> Usecase 3: ChromeOS VMs - each vCPU thread that is created by the VMM is
> tagged thus disallowing core sharing between the vCPU thread and any other
> thread on the system. This is because such VMs may run arbitrary user code
> and attack both the guest and the host systems sharing the core.
> 
> Usecase 4: Oracle - Setting a sub-CGroup as trusted (cookie 0). Chris Hyser
> talked to me on IRC that in a CGroup hierarcy, some CGroups should be allowed
> to not have to share its parent's CGroup tag. In fact, it should be allowed to
> untag the child CGroup if needed thus allowing them to share a core with
> trusted tasks. Others have had similar requirements.
> 
> Proposal for tagging
> --------------------
> We have to support both CGroup and non-CGroup users. CGroup may be overkill
> for some and the CGroup v2 unified hierarchy may be too inflexible.
> Regardless, we must support CGroup due its easy of use and existing users.
> 
> For Usecase #1
> ----------
> Usecase #1 requires a 2-level tagging mechanism. I propose 2 new files
> to the CPU controller:
> - tag : a boolean (0/1). If set, this CGroup and all sub-CGroups will be
>    tagged.  (In the kernel, the cookie will be derived from the pointer value
>    of a ref-counted cookie object.). If reset, then the CGroup will inherit
>    the parent CGroup's cookie if there is one.
> 
> - color : The ref-counted object will be aligned say to a 256-byte boundary
>    (for example), then the lower 8 bits of the pointer can be used to specify
>    color. Together, the pointer with the color will form a cookie used by the
>    scheduler.
> 
> Note that if 2 CGroups belong to 2 different tagged hierarchies, then setting
> their color to be the same does not imply that the 2 groups will share a
> core. This is key.  Also, to support usecase #4, we could add a third tag
> value -- 2, along with the usual 0 and 1 to suggest that the CGroup can share
> a core with cookie-0 tasks (Chris Hyser feel free to add any more comments
> here).

Let em think about this. This looks like it would support delegation of a cgroup subtree, which I suppose containers are 
going to want eventually. That seems to be the advantage over just allowing setting the entire cookie. Anyway, I look 
forward to tomorrow and thanks for putting this together.

-chrish



> For Usecase #2
> --------------
> We could add an interface that Peter suggested where 2 PIDs A and B want to
> share a core. So if A wants to share a core with B, then it issues
> prctl(SET_CORE_SHARE, B). ptrace_may_access() can be used to restrict access.
> For renderers though, we want to likely allow a renderer to share a core
> exclusive with only threads within a renderer and no one else. To support
> this, renderer A could simply issue prctl(SET_CORE_SHARE, A).
> 
> For Usecase #3
> --------------
> By default, all threads within a process will share a core. This makes the
> most sense because threads in a process share the same virtual address space.
> However, for virtual machines in ChromeOS, we would like vCPU threads to not
> share a core with other vCPU threads as mentioned above. To support this,
> when a vCPU thread is forked, a new clone flag - CLONE_NEW_CORE_TAG could be
> introduced to cause the forked thread to not share a core with its parent.
> This could also support usecase #2 in the future (instead of prctl, a new
> renderer being forked can simply be passed CLONE_NEW_CORE_TAG which will tag the
> forked process or thread even if the forking process is not tagged).
> 
> Other considerations:
> - To share a core anyway even if tags don't match: If we assume that the only
>    purpose of core-scheduling is to enforce security, then if the kernel knows
>    that CPUs are not vulnerable then cores can be shared anyway, whether the
>    tasks are tagged or not (Suggested-by PeterZ).
> 
> - Addition of a new CGroup controller: Instead of CPU controller, it may be
>    better to add a new CGroup controller in case the CPU controller is not
>    attached to some parts of the hierarchy and it is still desirable to use
>    CGroup interface for core tagging.
> 
> - Co-existence of CGroup with prctl/clone. The prctl/clone tagging should
>    always be made to override CGroup. For this purpose, I propose a new
>    'tasks_no_cg_tag' or a similar file in the CGroup controller. This file
>    will list all tasks that don't associate with the CGroup's tag. NOTE: I am not
>    sure yet how this new file will work with prctl/clone-tagging of individual
>    threads in a non-thread-mode CGroup v2 usage.
> 
> - Differences in tagging of a forked task (!CLONE_THREAD): If a process is
>    a part of a CGroup and is forked, then the child process is automatically
>    added to that CGroup. If such CGroup was tagged before, then the child is
>    automatically tagged. However, it may be desired to give the child its own
>    tag. In this case also, the earlier CLONE_NEW_CORE_TAG flag can be used to
>    achieve this behavior. If the forking process was not a part of a CGroup
>    but got a tag through other means before, then by default a !CLONE_THREAD
>    fork would imply CLONE_NEW_CORE_TAG. However, to turns this off, a
>    CLONE_CORE_TAG flag can be added (forking process's tag will be inheritted
>    by the child).
> 
> Let me know your thoughts and looking forward to a good LPC MC discussion!
> 
> thanks,
> 
>   - Joel
> 
> [1] https://lwn.net/Articles/780703/
> [2] https://lwn.net/Articles/828889/
> 
